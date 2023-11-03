Return-Path: <bpf+bounces-14120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC0B7E0A79
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F1E1C210CC
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 20:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B221F614;
	Fri,  3 Nov 2023 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrYhf4Pw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822A1549C
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 20:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149A0C433C7;
	Fri,  3 Nov 2023 20:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699044294;
	bh=5SQ6wzMy6O5Ms/+s/7eF56kHrnY6DpBEn4xTpzrOQKM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YrYhf4PwDj5S4hwv4UMIrEDt9acqy0VnEvsSsoPYl0POyn95RB0zjNp7JNoPb7+tu
	 lwLmjq+VN6agOvmUPtzTfPz4iXQx/Ph8597TDXNx/sJpiODujX+BMd58OmDpaJ/ulU
	 nKKpIe9tGF1xrHbLXAdliXdN2o2yrxn3rL//tQR1Are2rTyAzUmcIg0mTt0FzLhYsa
	 GcuB/FqHEHKWgEWoETWFw1AxCnOEjGYDD4ynuKHqX45ouCJiEi6ceaNvBjZAhI8dGM
	 DzqMdprWyEfz2vH2ZphuwJXLFhx3DIgMSUW1zDFcHSpR4CvM6L2Kn4SYoyUxfqkMJz
	 B7zDkW3tKkYfg==
Date: Fri, 03 Nov 2023 13:44:47 -0700
From: Kees Cook <kees@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Hengqi Chen <hengqi.chen@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>
Subject: Re: [PATCH bpf-next 1/6] bpf: Introduce BPF_PROG_TYPE_SECCOMP
User-Agent: K-9 Mail for Android
In-Reply-To: <CAADnVQ+V_ZVEjrzw80BQjyuf-Y78-raDrOVLSh+CO_G8-Uun-A@mail.gmail.com>
References: <20231031012407.51371-1-hengqi.chen@gmail.com> <20231031012407.51371-2-hengqi.chen@gmail.com> <6F41D669-AE0C-4CAE-9328-B03BFF7F5643@kernel.org> <CAADnVQ+V_ZVEjrzw80BQjyuf-Y78-raDrOVLSh+CO_G8-Uun-A@mail.gmail.com>
Message-ID: <C8AE6D6A-2A1F-4D58-8E9E-00698E6AC6E7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 2, 2023 12:53:56 PM PDT, Alexei Starovoitov <alexei=2Estarovoi=
tov@gmail=2Ecom> wrote:
>On Thu, Nov 2, 2023 at 12:49=E2=80=AFPM Kees Cook <kees@kernel=2Eorg> wro=
te:
>>
>>
>>
>> On October 30, 2023 6:24:02 PM PDT, Hengqi Chen <hengqi=2Echen@gmail=2E=
com> wrote:
>> >This adds minimal support for seccomp eBPF programs
>> >which can be hooked into the existing seccomp framework=2E
>> >This allows users to write seccomp filter in eBPF language
>> >and enables seccomp filter reuse through bpf prog fd and
>> >bpffs=2E Currently, no helper calls are allowed just like
>> >its cBPF version=2E
>>
>> I think this is bypassing the seccomp bitmap generation pass, so this w=
ill break (at least) performance=2E
>>
>> I continue to prefer sticking to only cBPF for seccomp, so let's just u=
se the seccomp syscall to generate the fds=2E
>
>That's fine, but let's not mix old things with bpffs, bpftool, etc=2E
>If you want an anon_fd then go ahead and allocate it standalone=2E
>It shouldn't be confused with eBPF fd-s=2E
>No bpffs treatment and no bpftool visibility=2E

Agreed=2E Let's just emit an anon_fd from the seccomp syscall=2E

--=20
Kees Cook

