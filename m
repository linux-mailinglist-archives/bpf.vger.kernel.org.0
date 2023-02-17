Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1688869B420
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 21:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBQUqK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 15:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBQUqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 15:46:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04E056EF2
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 12:46:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i28so8353840eda.8
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 12:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81TqDRXgkUTUw+bWuOLyqnzL0soN9oP7ioHOkR1YQHU=;
        b=PvlHDVp20iY71+gpNdY3tDFgjY39fwV6N3eGzSvtXRD/d/MaXfQanq2B1LVwEIrWKn
         aYTjyIcKTVT65P3armP/jkQ3r6TUDqxpPET88YWepArtYzJEAcSmFHqMFeKF1W0A9w35
         T7nBe03ktDunDIUk3G0Dso53tLFIDTqKm1GcimxzdZgJJvLdJHT3XvF74IIDY3bt1d5h
         pRE2mOB4lIHmnHr2lp7DilkJ1h4ITiEXt+ue19mS2XNZd5SdAqTjgtZ6ygcDz7C46XSH
         AxFCtAT8sYGUwwFWD9CSCLZWW5mv62k9aPaqeavatIu4fr+1Rz45xWUfcxz4Qf4u8DM2
         w+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81TqDRXgkUTUw+bWuOLyqnzL0soN9oP7ioHOkR1YQHU=;
        b=fSYRPBhV2MQMn6LLXTGRivcNv15KdQ8x6q2Kf/tMBmjwI94XxWMAv8IJ8ACcD6ZXDv
         /JpVIKdvtTNSCCQaQ5EySA3RM+GsMMSGu4zmqWBEWa1reH1oGq5fAnGyy0q6xbSPxcRf
         Phk3m6BniJ5hFdyuBcsOf2o+RKED4xuoWuB/7q/L0KVa7BdzHRfg5+GeR5pSGQUi3jnK
         SaUD84up6AlpZfM9lxlceNYAw+cAszvRS6CZ4nJYnrvF62xUg664mYRg8zuo/ZGIErU+
         9EcuLvfX/92tPfEsvUyFlCgK5vf+bYe1lIYIzCm282JOIM8viFw2jF8qrrineMVyEG0X
         ckwQ==
X-Gm-Message-State: AO0yUKUWi3b7KDiJyII4v4GDtiz7RIM6uxoFBtLPxmfC5IZ1ZcQcGb3y
        sJaVbalo+BHy5RyxYg4aQMU=
X-Google-Smtp-Source: AK7set90+JXKtqIQt+2WgwwXEqHXqd5b8+ZdEyDL5Vn0XwqNIrMw1lqkdm2ZVmC7BMOIiteCkeu7Vg==
X-Received: by 2002:a17:906:22ce:b0:8b1:bab0:aa3d with SMTP id q14-20020a17090622ce00b008b1bab0aa3dmr3652071eja.8.1676666767106;
        Fri, 17 Feb 2023 12:46:07 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g9-20020a170906348900b008b11ba87bf4sm1391536ejb.209.2023.02.17.12.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:46:06 -0800 (PST)
Message-ID: <fe4e2cf65d39ded9c6948ccf43e593eb29ab9753.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Allow reads from uninit stack
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Date:   Fri, 17 Feb 2023 22:46:05 +0200
In-Reply-To: <98d4936a-27de-95b3-d787-40b78654916d@iogearbox.net>
References: <20230216183606.2483834-1-eddyz87@gmail.com>
         <98d4936a-27de-95b3-d787-40b78654916d@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-02-17 at 21:37 +0100, Daniel Borkmann wrote:
[...]

> Ptal, looks like BPF CI is complaining:
>=20
> https://github.com/kernel-patches/bpf/actions/runs/4205832876/jobs/729848=
8977
>

Yes, I messed up comments in the asm blocks when replaced '\n\' line
endings with '\' before sending the patch w/o re-testing.
Sorry about that.

I'm waiting for answers from Andrii and will resend the patch-set.

---

Here is how the tests should look like:

/* Read an uninitialized value from stack at a fixed offset */
SEC("socket")
__naked int read_uninit_stack_fixed_off(void *ctx)
{
	asm volatile ("					\
		r0 =3D 0;					\
		/* force stack depth to be 128 */	\
		*(u64*)(r10 - 128) =3D r1;		\
		r1 =3D *(u8 *)(r10 - 8 );			\
		r0 +=3D r1;				\
		r1 =3D *(u8 *)(r10 - 11);			\
		r1 =3D *(u8 *)(r10 - 13);			\
		r1 =3D *(u8 *)(r10 - 15);			\
		r1 =3D *(u16*)(r10 - 16);			\
		r1 =3D *(u32*)(r10 - 32);			\
		r1 =3D *(u64*)(r10 - 64);			\
		/* read from a spill of a wrong size, it is a separate	\
		 * branch in check_stack_read_fixed_off()		\
		 */					\
		*(u32*)(r10 - 72) =3D r1;			\
		r1 =3D *(u64*)(r10 - 72);			\
		r0 =3D 0;					\
		exit;					\
"
		      ::: __clobber_all);
}

/* Read an uninitialized value from stack at a variable offset */
SEC("socket")
__naked int read_uninit_stack_var_off(void *ctx)
{
	asm volatile ("					\
		call %[bpf_get_prandom_u32];		\
		/* force stack depth to be 64 */	\
		*(u64*)(r10 - 64) =3D r0;			\
		r0 =3D -r0;				\
		/* give r0 a range [-31, -1] */		\
		if r0 s<=3D -32 goto exit_%=3D;		\
		if r0 s>=3D 0 goto exit_%=3D;		\
		/* access stack using r0 */		\
		r1 =3D r10;				\
		r1 +=3D r0;				\
		r2 =3D *(u8*)(r1 + 0);			\
exit_%=3D:	r0 =3D 0;					\
		exit;					\
"
		      :
		      : __imm(bpf_get_prandom_u32)
		      : __clobber_all);
}

[...]
