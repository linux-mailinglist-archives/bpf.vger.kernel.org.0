Return-Path: <bpf+bounces-12475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A327CCBDC
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 21:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B072813CE
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC07B2EAFC;
	Tue, 17 Oct 2023 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ+t2VfO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A632EAF5
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 19:11:10 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525290
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:11:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d9552d765so4710935f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569867; x=1698174667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDvAFyKusjYaaaVBW3+d3CTDtEmXV52SJOeZ4ehAiVY=;
        b=LQ+t2VfONdBNzpcMrVzuZnSi+qspaEQEM9/R9rgk7XJzNqAOzIaaHSoUKKtpjulf+l
         UGdb3CDEy3LO+AaG32Aa0RABR0bSzbXV2pDqwFvMpyspUFE4QBQX6fuGNbBGHQi38y2i
         8kKVNXl1BDYWktGO9jMlm1p81GHR9YGDtiC5BiBzNK/dh9dc0FziYj/S7EYiM/BRnU43
         fejmpG4JC0odlY97VUj/MB0WsOsx6V0XUhtCYoy6j08BY/WZ0HlcqqxWysczNWDTbYEZ
         iYQFxVG+CsFlNuXWEr1s1M0kToLq5ry2779z0dR9+K8qtEzpkwUeblXlv2CdSTk2D8BH
         +/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569867; x=1698174667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDvAFyKusjYaaaVBW3+d3CTDtEmXV52SJOeZ4ehAiVY=;
        b=Zo4G8lZhorgcqb9SkV2P9woMuo88dmV5rDB32gKC7tWyvCERn/NLhs42xa4dxd00p9
         V9j7wqyuQcH3sHvQIJ04UyvROjy1Yucx9mwH7tETo8Wo8m6zIgsrOiTJmZcMpuZSNq+f
         EEojD3KaemB9OdurtIBFyKuKLxDa/Db8kD/fQHgvHIkkmKBa01AT5as6oDMXnvtiqSwp
         QjFdNlf51cvCA8Wpee6fkoKL7KQNmGSNH5AzSMj3nKxpo71fjYBLeygmkw3ofjwaR/ce
         NFvG2chUtSXAeyn0e+mDsFSEzbpuEeHMocJAMXH6Oz+bdwutE+bXvX/whHbTB5rCaCI8
         GtXg==
X-Gm-Message-State: AOJu0Yz8duRtAqlyPgcPoHScSAtSefcjltWObxofNjlB2P737bRikE1d
	6SCze3gFmxK6NhevQiDSS0SuzLD/TmfDCeIDUAI=
X-Google-Smtp-Source: AGHT+IFTswGL7KEaRVV6S0ufVLT5CxSMmXDZSBKHyFjVMcpvS3n2YhqOrw7MJABLIZBfGAvxtVrpvmFPYoM6Q/a4ryY=
X-Received: by 2002:a5d:4e0c:0:b0:32d:9a1b:5d80 with SMTP id
 p12-20020a5d4e0c000000b0032d9a1b5d80mr2503784wrt.35.1697569867506; Tue, 17
 Oct 2023 12:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013182644.2346458-1-song@kernel.org> <20231013182644.2346458-2-song@kernel.org>
In-Reply-To: <20231013182644.2346458-2-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Oct 2023 12:10:56 -0700
Message-ID: <CAADnVQLcrxLatupH=i2Q-K8KRF72PqB8wayC=UEKvuMMn3ie7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
To: Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, fsverity@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 11:30=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> +__bpf_kfunc int bpf_get_file_xattr(struct file *file, struct bpf_dynptr_=
kern *name_ptr,
> +                                  struct bpf_dynptr_kern *value_ptr)
> +{
> +       if (!bpf_dynptr_is_string(name_ptr))
> +               return -EINVAL;
> +
> +       return vfs_getxattr(mnt_idmap(file->f_path.mnt), file_dentry(file=
), name_ptr->data,
> +                           value_ptr->data, __bpf_dynptr_size(value_ptr)=
);
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(fs_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)

I suspect it needs to be allowlisted too.
Sleepable might not be enough.

KP proposed such kfunc in the past and there were recursion issues.

KP,
do you remember the details?

