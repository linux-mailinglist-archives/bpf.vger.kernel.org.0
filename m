Return-Path: <bpf+bounces-7183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77F772A67
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544F3281468
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F82311CB4;
	Mon,  7 Aug 2023 16:19:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3220FE
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 16:19:28 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D001715;
	Mon,  7 Aug 2023 09:19:26 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bca88c3487so3899269a34.2;
        Mon, 07 Aug 2023 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425166; x=1692029966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueDJCiGb0+VI2kQKDZzwR188POLai26iF4UpeUbxBio=;
        b=cEN+n13HcILMDBD4BVySkhuM05g/mdSJjr5pgPn1UxGT7ofe7f8VJ+GSEB5Q9zRvHK
         PgZnDX6FKIZdfFhfe/9WZWb6hnsuIQg1yShCVdIhICq57+jKDxzd+TmFqcaWJVTQpWmx
         Lo/CnO1UrNaGmy3EZsrsyTVedNdGyCz8bEg9YzodMdLluNRn7r7HO7hd0csRsRedHjR6
         LLy2SHBSZt4VxN5I5E44l/h7nXguFuzyK4G6ntJc3w/X3Lsep1DuEdPJlORqlNQLqKx5
         INKus0QaQQLJyw/+zQLyB5Nz+guwfSNI5jOvZEFf+Rd4wXN/wk9V8bOW9Eu7cSCyO/eV
         FqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425166; x=1692029966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueDJCiGb0+VI2kQKDZzwR188POLai26iF4UpeUbxBio=;
        b=VOorkZ5e1+SlVREUoHGzqSfJ4jCheddz5X16oZMNbi3EAv3WxYliHB67UmURckWTI2
         7e/5Tc0gX1+0KRpJwYv4ID5bumZp7MIH7uylndOjXUrKGKMSl+EyHPExwC1dMmbRHCkv
         FOYWWakdLPeIYnb29/5cUBFj8UG9TwpJ2s3NgH0mY8dTUSGVtCgysc3nhGKJK41WpZbN
         Kuce6goQ1aQ27zVsj1yjm2pmvxWk99a9SWAzQob8VN7I/ibajlTP7zllcospyoiEEA62
         +eyWGvl+tNGWSoi2BUe5xehbbQUMsiWTuBIMr6t0d0nB354qJE9xsRi7CgLeAatRDUOS
         6yfQ==
X-Gm-Message-State: AOJu0YyFh5Jvr470Kxf24zsgTrEROyIsYf+6LtMHBPQ59hl7RG5SwsyT
	VyFTg6FEP6b7ZEVQ1FwLWyXcpmkigTAcLDjxxnU=
X-Google-Smtp-Source: AGHT+IG0zZ/NC5YCFbFprxdGk2LwxzUELIioHWKhlvdgppPMZqBOFHEIFzBi+JAjU3rM+4HpE3EYPBJSEVvIi3n9+R0=
X-Received: by 2002:a05:6870:c20d:b0:1be:d522:fdf with SMTP id
 z13-20020a056870c20d00b001bed5220fdfmr10569352oae.12.1691425165703; Mon, 07
 Aug 2023 09:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801012608.4003-1-sunran001@208suo.com>
In-Reply-To: <20230801012608.4003-1-sunran001@208suo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 12:19:14 -0400
Message-ID: <CADnq5_OzhDL6tfu2HH2SDEQOnPukvoM0fPm3NN9ORSqOxrq1Wg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0_7_ppt.c
To: Ran Sun <sunran001@208suo.com>
Cc: apw@canonical.com, joe@perches.com, alexander.deucher@amd.com, 
	bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Applied.  Thanks!

On Mon, Jul 31, 2023 at 9:26=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: spaces required around that '=3D' (ctx:VxW)
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index b1f0937ccade..26ba51ec0567 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -386,8 +386,7 @@ static int smu_v13_0_7_check_fw_status(struct smu_con=
text *smu)
>  }
>
>  #ifndef atom_smc_dpm_info_table_13_0_7
> -struct atom_smc_dpm_info_table_13_0_7
> -{
> +struct atom_smc_dpm_info_table_13_0_7 {
>         struct atom_common_table_header table_header;
>         BoardTable_t BoardTable;
>  };
> @@ -494,7 +493,7 @@ static int smu_v13_0_7_tables_init(struct smu_context=
 *smu)
>                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>         SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>                        sizeof(DpmActivityMonitorCoeffIntExternal_t), PAGE=
_SIZE,
> -                      AMDGPU_GEM_DOMAIN_VRAM);
> +                      AMDGPU_GEM_DOMAIN_VRAM);
>         SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE, MP0_MP1_DATA_REGI=
ON_SIZE_COMBOPPTABLE,
>                         PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>
> @@ -728,7 +727,7 @@ static int smu_v13_0_7_get_smu_metrics_data(struct sm=
u_context *smu,
>                                             MetricsMember_t member,
>                                             uint32_t *value)
>  {
> -       struct smu_table_context *smu_table=3D &smu->smu_table;
> +       struct smu_table_context *smu_table =3D &smu->smu_table;
>         SmuMetrics_t *metrics =3D
>                 &(((SmuMetricsExternal_t *)(smu_table->metrics_table))->S=
muMetrics);
>         int ret =3D 0;
> @@ -1635,8 +1634,7 @@ static int smu_v13_0_7_force_clk_levels(struct smu_=
context *smu,
>         return ret;
>  }
>
> -static const struct smu_temperature_range smu13_thermal_policy[] =3D
> -{
> +static const struct smu_temperature_range smu13_thermal_policy[] =3D {
>         {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 9=
9000},
>         { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,=
 120000},
>  };
> --
> 2.17.1
>

