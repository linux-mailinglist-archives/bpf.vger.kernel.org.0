Return-Path: <bpf+bounces-43420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57459B54FE
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15110B216BD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83159209F4D;
	Tue, 29 Oct 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCwtmL7y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB11422AB;
	Tue, 29 Oct 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237046; cv=none; b=O0kWAfwWGSfv0aXo1b/7/P8vz6gPLBYuascddJbx5tC82kMqz2ajVNhLNPerTVY6nny02HN5FJvCnSMwAg1BwXoxVJHS4sY6I1xkETHQIntMj+1nUO0VkeEGbNW6Ky3S7xho3kuiBMBxHMC+g5NTYa6H04FFe2+KHk2JXptsv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237046; c=relaxed/simple;
	bh=AlDqv16DLyqJX0LYL4Yc+pwGFq9PSpoMiRq+vxU8mXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxyKUEk7wbcbItOIRHQ0uvoy/JkKHHIgKnbea4VuPmiv2k1zXFaCh2MZIteFyJUuN1o31RT8fUQ+U0Tbktk+QFX3hMjY4SPU52mjsREWYwBL70DXy0M8DW3FXiWGCFFEbD1pPWslTE9JUi2IHryKJ54RTdfvmQ/J8qHxmVOAbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCwtmL7y; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2e3e4f65dso63396417b3.3;
        Tue, 29 Oct 2024 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730237043; x=1730841843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlDqv16DLyqJX0LYL4Yc+pwGFq9PSpoMiRq+vxU8mXM=;
        b=fCwtmL7yHeC8b7EZdNAyQ8O7+yUSaCPILZtSsQFkdUBkXpZDStuMazvXTLpj1AFhbk
         abrm97vdtddFM9gtTm91tfXbozWIJyjTOGoWoPB61C960Racmxi7/SmyCJf7i4RE/S0A
         RF90uOkjjbBf29HqSMOYB2O4SLIVjqJ7AL+DoyEhYmSb5Hld1OZkx00QV9YCtTEjooYr
         kBn0XKCb7yiXt16GhWRLJEmFLjG1Y9acv1qbwR+7jm+bu3jZDjusFh804u/BJPCJw1iW
         UzXzhfEeFCCCbztbomHVfmBwIkBPf9X+lz0TGhwJ1FfuP9gCjIlAY4krz5/x5bzWAQUw
         yPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237043; x=1730841843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlDqv16DLyqJX0LYL4Yc+pwGFq9PSpoMiRq+vxU8mXM=;
        b=KlDNNhUQPgOzatbuaS7pCmJ+yEBYCZKHL7yoNYBjKPjNElrwUbTbnRIRBdcqy5r4G9
         OfxLH1yndWXhHT1UytyEHVHTMb13n95fYFrWrbqalNsmPYZWKzqQ+NIdEWWb1nDTcMEl
         tNXg5DgKRFCX/TILfbbV9f/JNqsOmyjGhofG9v0vNnc1gcXwLuP/fsmQrMCflnLMMIMH
         kQK7ZdZVovNQkAje2s+KzmCkqFOb42zonmcidymLC2uHk/nL055f2ta9/xLa92R+1300
         SIFnalkO+TGuRk9pCks4XeS1i9Lk7xoQlktm0PF3LvauECsCmMDjfjExwNGOEbEPtYrJ
         uEeA==
X-Forwarded-Encrypted: i=1; AJvYcCUXsi1kVRo/i8NAAR3+W3tbxUYDKe9k+9Um1NuiVkbDQkN/9DYyqQApv1rswZAKatCRNK29lgq9d3fU+Bhh@vger.kernel.org, AJvYcCVdYk7IBBGpLBmzmFJHwXpqnHGUFzfWrzYFeBekwKfAJiJLNkBxXH7CBdWlXWYK8T5z2ehhqUQR@vger.kernel.org, AJvYcCWwF1NLk86fh7vqoo+jsEzvOEQrumt0TzEsx+3+FsckReLVYLXDuPMQyN/j3aD6S5xIUlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHzSoendm6cD/XiqASbFpJa0Bo/sWoCXl1g+d6i6U1iNzcwEb
	6AIZU/BKkY/Xxta30FtzUnT1vF6ZfPGoh2UYDbKbaqIoT3N8oM2Dc1loVCn7DV0M6uEl/qDAoeH
	B/UsaKGA7kSO0OYHgHbww1B0tD8Y=
X-Google-Smtp-Source: AGHT+IHWVqyl2ahMFQfMzr5lYHfv4WPYfQSq7O3ZPsrjne23k4ROGsNq13egSmoVGtGYbVJK1jbALw5kP6hguOivOjQ=
X-Received: by 2002:a05:690c:4989:b0:6e3:41d4:1016 with SMTP id
 00721157ae682-6e9d8a7620dmr149368057b3.25.1730237043143; Tue, 29 Oct 2024
 14:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019071149.81696-1-danielyangkang@gmail.com>
 <c7d0503b-e20d-4a6d-aecf-2bd7e1c7a450@linux.dev> <CAGiJo8R2PhpOitTjdqZ-jbng0Yg=Lxu6L+6FkYuUC1M_d10U2Q@mail.gmail.com>
 <5c8fb835-b0cb-428b-ab07-e20f905eb19f@linux.dev> <CAGiJo8RJ+0K-JYtCq4ZLg_4eq7HDkib9iwE-UTnimgEQE8rgtg@mail.gmail.com>
 <c0e98969-a75e-45a0-803c-1d69bf02623b@linux.dev>
In-Reply-To: <c0e98969-a75e-45a0-803c-1d69bf02623b@linux.dev>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Tue, 29 Oct 2024 14:23:08 -0700
Message-ID: <CAGiJo8TmtUq3ogd+4gfSXM4MpFV48EhOTAGwFVAuGhwNaYFzCw@mail.gmail.com>
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN infoleak
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <bpf@vger.kernel.org>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 10:42=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
> It might be due to your .config file.
> The 'struct syscall_trace_enter' is defined in kernel/trace/trace.h,
> which is used in kernel/trace/trace_syscalls.c. Maybe your config
> does not have CONFIG_FTRACE_SYSCALLS?
I did add it to my config but another error popped up after I tried to
rerun the tests. I just ended up using the vmtest.sh script and got
the tests working. Seems like there should be a template config file
or something to make building locally more convenient. Anyways, thanks
for the help.

- Daniel

