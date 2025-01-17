Return-Path: <bpf+bounces-49234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A2A1591E
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 22:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07197A11B6
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 21:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFCC1ABECA;
	Fri, 17 Jan 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQN1j2Jb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1169D1AA1F1;
	Fri, 17 Jan 2025 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737150046; cv=none; b=YPrQfOoUTr4gr0AqSeuThljfa6Ds6rcCrMattDjEnp6qm3PDQGfFOvIvX8PdhUNUBRMuYza9ghrDAcpFvCDE7lKZ766Kmj8bMqxLgf0hlNbKpR60h/Zc+8lE0Z7FqAWCc8RXsYqklI3ErFxOZ1u0+Ro3bfh5qblHdoAoyRjveLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737150046; c=relaxed/simple;
	bh=IeoyIgmvNEmMtBhZ+AJxFIv9hjz9g8oltVor1l0jOSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7gE6NE6+Eg9OLzZVgl7xGZmrTue9sOwQBNyb24gMOhdiQ0KtMkukzdEVcFjU/2gDfpzcqV9+b9U8CpcoDAbcbF1pGGzl77E2luvQcFMcVO3va+6/i6xg+ToXEmbnD59l5JDSQ1AJ3+uoEZpJNRSF2DvV1/jO9RkOfnSOMU9WLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQN1j2Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8703FC4AF09;
	Fri, 17 Jan 2025 21:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737150045;
	bh=IeoyIgmvNEmMtBhZ+AJxFIv9hjz9g8oltVor1l0jOSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fQN1j2JbyDHGseIpzRjRwTazuOFLH6UQKO79MHmjQtuVntLuRA9JEGSJhdT3S1UZE
	 hRVz9bHvIfTjLUHD4HnrVYYmqI5Qem0ph3eSX/laFXuWXAwp9hn60oSKVfWFbY7DR6
	 19WHKeOcANMdvaJ4IuAPnSX5Mxul+8oEjMZrABukGHZZPyW+2/hIE3Iou4s9anIump
	 yeZRZdHBgbk6Zckjo8FKBuPlifXeUAR8KaIBsB9wVPrNqWyfSldqoMP8e/oP6lB/Ko
	 5Z8VrZ7jvMTNbpR8PE5UmrYFveBVYzLYX0fGK8oX+ZA8M8KYA3l2T+v/6vvWfKpoIv
	 /gS/PLqnaCvtA==
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844ee43460aso177363639f.1;
        Fri, 17 Jan 2025 13:40:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSHKx6PVbIP6CflpyWBI7+ZoodJHqkrshvLI2QiNNXMayih7+yhrn7TbOLHkJZEIuLGLdzhwsktXnxDBQM@vger.kernel.org, AJvYcCWyjtz8Pqm4egwo3xFIXecADui0/IrEBuk5LAMORGvoZKO2wDynQrvrJJ41JQhFdsUhD4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkZCpIjPhGIBG5cMdilx5OSMmCP9uQtEI7fvqfyL7uk/GVULu
	syb5+0wnkxAHt0zgDg7t9QKrs8SpDzUAvtQvuNeQYYLgI2XBcbGjadaapLFOMUMkVT/+W1S6RN2
	pSI6Lr7LoPdjx08fmprV5jbz26n0=
X-Google-Smtp-Source: AGHT+IGuFoXX/oLkhJ85StNzHyBs/FBby1SKMTz8fzeMnWz78zY7GQH4XwKYG1eRry866KTcO/39vNqa7joV0SERpZE=
X-Received: by 2002:a05:6e02:8e:b0:3ce:7cca:db3e with SMTP id
 e9e14a558f8ab-3cf744b0115mr41022125ab.19.1737150044919; Fri, 17 Jan 2025
 13:40:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508044E85205F344C4DA4B5F991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAPhsuW4F5uyJKa2Gg1QYRy8_FBERgaj=z4smxtjKa5NF_Zac8w@mail.gmail.com> <AM6PR03MB508002DCA7DBE7C7712ECC30991B2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB508002DCA7DBE7C7712ECC30991B2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Song Liu <song@kernel.org>
Date: Fri, 17 Jan 2025 13:40:33 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4sd5LgmPjceFqaLGu20N4EVxRB_-FWOm5vcCGcRPa3ZA@mail.gmail.com>
X-Gm-Features: AbW1kvZmdBpPw8JfV3BbuQ-O3N9cFa7jlZKwGjKcILuMTVEGNej9-7tmwf0MsZA
Message-ID: <CAPhsuW4sd5LgmPjceFqaLGu20N4EVxRB_-FWOm5vcCGcRPa3ZA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/7] bpf: Add enum bpf_capability
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, tj@kernel.org, 
	void@manifault.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:37=E2=80=AFAM Juntong Deng <juntong.deng@outlook=
.com> wrote:
>
[...]
>
> Thanks for your reply.
>
> I am not sure if BPF capabilities is a good approach.
>
> But we currently need filters because we register all kfuncs to program
> types, which are too coarse-grained, so we need additional filters for
> further filtering (make the granularity finer).
>
> We added struct btf_kfunc_hook_filter and added filter logic in
> btf_populate_kfunc_set, __btf_kfunc_id_set_contains, essentially to
> mitigate the problem of coarse-grained permissions management.
>
> If we register all kfuncs to BPF capabilities, then we will no longer
> need additional filters for further filtering because BPF capabilities
> is already fine-grained.

bpf_capabilities_adjust is the filter function with a different name.
So the extra capability concept doesn't give us much benefit.

>
> Would it be a better idea for us to let each kfunc have its own
> capability attribute?

This is no different to the BPF helper function ID, which turned
out to be not scalable.

>
> In addition, BPF capabilities seem like a extensible idea. Would it be
> valuable if we make other features of BPF (BPF helpers, BPF maps, even
> attach targets) have their own capability attributes and can be managed
> uniformly through BPF capabilities?
>
> For example, if a bpf program has BPF_CAP_TRACING, then it will be able
> to use kprobes and can use tracing related kfuncs and helpers. If a bpf
> program has BPF_CAP_SOCK then it will be able to use
> BPF_MAP_TYPE_SOCKMAP and use socket related kfuncs and helpers.
>
> In other words, if we add a general internal permissions management
> system to the BPF subsystem, would it be valuable?
>
> BPF is general, and it is foreseeable that BPF will be applied to more
> and more subsystems and scenarios, so maybe a general fine-grained
> permissions management would be better?
>
> Fine-grained permissions management will bring potential flexibility
> in configurability.
>
> For example, if a system administrator wants to open the features of the
> HID-BPF driver to users, but the system administrator does not want to
> open other BPF features to users, such as sched_ext.

This appears to be a totally separate topic.

[...]

> Maybe we can have more discussion?

We sure need more discussion before shipping any changes for this
topic.

Thanks,
Song

