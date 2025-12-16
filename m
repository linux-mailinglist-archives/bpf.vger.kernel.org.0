Return-Path: <bpf+bounces-76751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FE5CC4FEC
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 098753036CAA
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591BF2DF6EA;
	Tue, 16 Dec 2025 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDIYg465"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64223BF9B
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765912854; cv=none; b=u97QZrTyytcnAVYusM5INY3/ZuBeTTb0MDpz4jExIolwvFroFcxWmI8z/+PAfI7jVIS2DyRrjtxEqQNaYdv7hrdxgIqzTNEYTVSuBBO5gMFNIxrVkxH0H8JlvtCw7yjWd1cl2E7r33ULdd0nuF07Liu/9lMDnh+p9Nsmc2F57YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765912854; c=relaxed/simple;
	bh=dLqbreUt5YNKXs8E6gWGXUSJdDTSJ/W3OmD6663EyqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHEUIw/F1BQWG7H4DBFCnDQus1Pe5viHncLt9kJHgdssxsGhrEvUOWf9kDr1kZZyXLlCJIADIpNd70QpicPWoV830Vx8dYjmmr6J/8+z4kOko4778yHVpaIuAU1hf+A5Dhhauz59WyO9bzppKzL3DFvPzpmTUdT/8eASKuvxBQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDIYg465; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E63C19422
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765912854;
	bh=dLqbreUt5YNKXs8E6gWGXUSJdDTSJ/W3OmD6663EyqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SDIYg46530UeFT3YA7MdQUfGdZf7RECa1ZvPi+C8VT3Nf5MNkqwX1QWfqy2wfSOJs
	 4wlywhUKFN44KOOJISvKkB9KNqQrcDsNkNVix9XSDK2eDyf0WPetaLl03M1XqcIFDb
	 ouqsQtULy70sZZFtKcu5rmATGmAtg7uef+t2olcqUoDVowLjeDUA4Vg6s2HXtJlRIY
	 91Vis3tZPtwa9jbXUDW4TmRWrhEOfiSRczwgidBS5gdhRViVcVGugI7OzQdE5WlvYh
	 YmnAPIN/bFdQuOSobHKxGNpoBWTnYZeJGWrL5LNiqwmGCSDWPW52Tm3zyH7xdjo6Tl
	 X3Z24cYoiva1Q==
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee158187aaso46854101cf.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:20:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPeAYQrULi4akky+yvBH6slV3MGVru0tekJAm1v0vdS7VHnkDFJ5/OIw4/I6+ZXO7YI+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ituXRS4cUf4SRxdgY4uCubkRpBaaBkACsz9+xfoVPfyPrOrn
	svPVMFAmUw4XfRdxH2V5CO0AsEV1WUhN3wlaHup0DlChGelOQ/yu2aIosBYE0PqvYNCEUsBqbrm
	UbvIbRk+iq9QGUIeMymQe9prCxwtYmtU=
X-Google-Smtp-Source: AGHT+IE68gnNYhZYxV0JG88V0RvC1uNzzFVoz4fPULrRHuHu3QN/VkgNXbyvT0+AVhkCDmsGNr4uzAu0FrZejzxG3vA=
X-Received: by 2002:a05:622a:1791:b0:4e6:ebe3:9403 with SMTP id
 d75a77b69052e-4f1d059d261mr191143981cf.41.1765912853516; Tue, 16 Dec 2025
 11:20:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
In-Reply-To: <20251216171854.2291424-1-alan.maguire@oracle.com>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Dec 2025 04:20:41 +0900
X-Gmail-Original-Message-ID: <CAPhsuW5WANNgTL0F=buM93ABnDnJgScgUSDN3p0jRATP8bwTVw@mail.gmail.com>
X-Gm-Features: AQt7F2qk5h_eVqn6GlJIqrJjS0_99VWS0Xk9YAHEpZEtmXlVDhDUHVE7I4I_uz8
Message-ID: <CAPhsuW5WANNgTL0F=buM93ABnDnJgScgUSDN3p0jRATP8bwTVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Handle -fms-extension in kernel structs
To: Alan Maguire <alan.maguire@oracle.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 9:20=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> The kernel is using named structs embedded in other structs
> with no member name (similar to anonymous struct usage).
> Such an arrangement causes problems for compilers unless -fms-extension
> is specified.  With vmlinux.h generation we do not want to impose
> that on the vmlinux.h consumer, so generate a compatible representation
> using anonymous types.
>
> Patch 1 adds libbpf support for this in BTF dump code; patch 2
> adds bpftool support to use the new option.

As Alexei suggested earlier, let's target the bpf tree. Please also test
again upstream (v6.19-rc1). I am seeing some weird errors in my
local tests on v6.19-rc1.

Thanks,
Song

