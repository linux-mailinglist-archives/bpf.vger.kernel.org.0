Return-Path: <bpf+bounces-3853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9A745361
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 02:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1166F1C2084D
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18BE386;
	Mon,  3 Jul 2023 00:53:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA3362
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 00:53:44 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4F1E44
	for <bpf@vger.kernel.org>; Sun,  2 Jul 2023 17:53:43 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-38c35975545so3091753b6e.1
        for <bpf@vger.kernel.org>; Sun, 02 Jul 2023 17:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688345622; x=1690937622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YIl3ZWl3QyLgO2B2pfQROc9bdW4usFyk2hfLJv297g=;
        b=akuKmUfWa3wV3aLlC5glsCPHE+IcnAkaFrGmCRTEqD3S1ofdWcINx2qiGFmG90p0iE
         NN7DvOETWzWAW2B1l+Ud4+XYKHSYB+ebuj+7c6jltdJFlGDy+zUG49/miXwsI/5y7ZrV
         EIh5eDxVmmN8tqHQeHFZa1SxsGwDev0ZAMwHYBZYPIARUJpbyP+Oqfexq5sEXw5aZKV5
         ZDROTlpwmMt5eCR5PzTjfp9GdbI2JADfK+aevvONkOF+VYyWrr2f2r+ko2sztgmR55jW
         x7MocJdw0dg7NOWVedfpytMvDwpvOSmtoRKCNCSatW6NOWpcq7om5dgXfnxd4qix43cP
         97LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688345622; x=1690937622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YIl3ZWl3QyLgO2B2pfQROc9bdW4usFyk2hfLJv297g=;
        b=WM75x92qXWHybF04I8vj74OUpUOkWZzm5bXXscYwUWGsQW61gUuCmi9qYjz0m1b0ON
         zzlxACkbZ8Wu3kBa1IT0gxqkb6+3aOQYrTe3rbuZ739mRAZvdYgUuvtBbk+o9N1hYPSR
         cqHwKHwAdBFu9FrmP1MPyiQeGbw2aZ3oEZ7eCMvmMsoRVlRMuCFVDJl5Oa/oZk2usBG4
         bLp4UoXkBUvDL7TCcWW5VrCy/DXYzPO9GkgIl2lNTTO8FQLvuSsjavaqmk5ggUui1Cfm
         u8P0tcTuwkZDOAM/XupISDWC8n3BfF4SZaK+5RZ+9t50VRznLEswwFwMUkGuvhOOMyMO
         +JbQ==
X-Gm-Message-State: AC+VfDx6Mk0wk5YfkGKgkXH63cDo91cu2nu9GtBOJ35LMahYTKcqWs9A
	x5pKdR+VjADjuk+90b1F4Uw=
X-Google-Smtp-Source: ACHHUZ7XDInD8siLTuDbwkkw0Q8FGsrnZ0tkIo0JwMhnUdtKBvN14o+VsA4asZlQYddCS3Fq9sQjow==
X-Received: by 2002:a05:6808:a93:b0:3a2:8453:39ca with SMTP id q19-20020a0568080a9300b003a2845339camr9241489oij.14.1688345622383;
        Sun, 02 Jul 2023 17:53:42 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b00679dc747738sm10660860pff.10.2023.07.02.17.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 17:53:41 -0700 (PDT)
Date: Sun, 2 Jul 2023 17:53:39 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Fangrui Song <maskray@google.com>, kernel-team@fb.com
Subject: Re: [RFC PATCH bpf-next 01/13] bpf: Support new sign-extension load
 insns
Message-ID: <20230703005339.zjljypzmyhh73cfa@MacBook-Pro-8.local>
References: <20230629063715.1646832-1-yhs@fb.com>
 <20230629063721.1647917-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629063721.1647917-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 11:37:21PM -0700, Yonghong Song wrote:
>  
> +/* LDX: dst_reg = *(s8*)(src_reg + off) */
> +static void emit_lds(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
> +{
...
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 60a9d59beeab..b28109bc5c54 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -19,6 +19,7 @@
>  
>  /* ld/ldx fields */
>  #define BPF_DW		0x18	/* double word (64-bit) */
> +#define BPF_MEMS	0x80	/* load with sign extension */

Intel assembly instruction to do sign extending mov is called 'movsx'.
Let's adopt SX suffix here and in other patches ?

s/BPF_MEMS/BPF_MEMSX/ here.
s/emit_lds/emit_ldsx/ above.

s/emit_movs_reg/emit_movsx_reg/ in patch 3.

s/bpf_movs_string/bpf_movsx_string/ in patch 7
s/bpf_lds_string/bpf_ldsx_string/ in patch 7.
s/is_movs/is_movsx/ in patch 7.

sdiv/smod can stay as-is.

Naming is hard, of course.

