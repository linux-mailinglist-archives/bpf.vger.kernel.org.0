Return-Path: <bpf+bounces-9224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F1791EBC
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 22:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6902810DB
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6FCA4B;
	Mon,  4 Sep 2023 20:58:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CEFBE6A;
	Mon,  4 Sep 2023 20:58:36 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C0A1AB;
	Mon,  4 Sep 2023 13:58:35 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b962535808so28019551fa.0;
        Mon, 04 Sep 2023 13:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693861114; x=1694465914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWYc1sN2nZiLgbOMsS1/d9hhys3KH6dtJS1x0YVZ6sk=;
        b=bd+4jJcsq0XOsoeljB5O/qZsAx6g1eDe2iLR7Yb18eRNzy0Zpyo8BtSmFAYBAfiiZ0
         JwqH+0cjyQz/VtLTH3562Y9ZTCCtQux4RbNW+gARIol1Ljg04dGwELoccvyAGBJwswLd
         mKI7v+rAY6iMWeu2sd/GfzXANgeh4qra2UVXPfVcJ0SD2r98zfSSH6WZWoxJRoE0KDYK
         liKIeqqcEAbFH+sVehpRS6MeFDKFfLIHL8zuAnMc9gtc8H3GtSMmH4rtC87wa4tI2Wc6
         wAE/WHF4A5zonlgC0ae/oG8ts9/O9IbCRUbryinv3W23lGvjV5iv0jervjGqm10BfYB3
         yMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693861114; x=1694465914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWYc1sN2nZiLgbOMsS1/d9hhys3KH6dtJS1x0YVZ6sk=;
        b=EfHnAPPR5eklzrbz9N7yxW+Aba5S9uXiyT1/t0TyPkhrMnmMdvE62NJc7PI9decJ75
         zFRbeeBjcQHf40HK3d0KWI9F2P+ZI709rvyGd9LDTjUAm8ohpP2taPJpt0eMEZL9OxdR
         NKSr3fF09ma5cj1ZdXTKTL8ydcP+l88+mJiwOS48sGN2REmd6eWDAZ1oRG1bprr9Y+hp
         vCrCs72G0O1D2A9WDu/hDLPeLavgOI/wvw7UklmNwQxUR4bau2piAT1L+5mDXby+df5Y
         +v3zWGGhNl8w9yl7Grz57lKR3CFLKq70Q2by7O5Ty080sGDPXoDSSdvW+ODry/B2oXeE
         v1DQ==
X-Gm-Message-State: AOJu0YznnV1AVCOkAia5kcTfN3m00ohVkCzgmO45AWtmgI8+wCC5Vqdp
	YXUw9lNn+VbNEThV4/7bL2S7/TwsiokvRKdw5QA=
X-Google-Smtp-Source: AGHT+IE8xvsGBNlDMmIAu5unfig1svHr/w7DkNii332TZpP+P95CQn8Vgee7WGQuUkIB2xM3fnvW2ht6JgLNJthWAus=
X-Received: by 2002:a05:651c:219:b0:2b9:aa4d:3728 with SMTP id
 y25-20020a05651c021900b002b9aa4d3728mr7663082ljn.29.1693861113415; Mon, 04
 Sep 2023 13:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com> <20230831153455.1867110-4-daan.j.demeyer@gmail.com>
In-Reply-To: <20230831153455.1867110-4-daan.j.demeyer@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Sep 2023 13:58:22 -0700
Message-ID: <CAADnVQLiUZpCvP+XXvOFQYaByzxDOVk=ALzV5Z0N8FqMaOh03g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] bpf: Add bpf_sock_addr_set_unix_addr() to
 allow writing unix sockaddr from bpf
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@meta.com>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 8:36=E2=80=AFAM Daan De Meyer <daan.j.demeyer@gmail=
.com> wrote:
>
> As prep for adding unix socket support to the cgroup sockaddr hooks,
> let's add a kfunc bpf_sock_addr_set_unix_addr() that allows modifying a s=
ockaddr
> from bpf. While this is already possible for AF_INET and AF_INET6, we'll
> need this kfunc when we add unix socket support since modifying the
> address for those requires modifying both the address and the sockaddr
> length.
>
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  kernel/bpf/btf.c  |  1 +
>  net/core/filter.c | 32 +++++++++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 249657c466dd..15c972f27574 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7819,6 +7819,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_pro=
g_type prog_type)
>  {
>         switch (prog_type) {
>         case BPF_PROG_TYPE_UNSPEC:
> +       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>                 return BTF_KFUNC_HOOK_COMMON;

hook_common means that they are shared by all prog types.
See btf_kfunc_id_set_contains().

