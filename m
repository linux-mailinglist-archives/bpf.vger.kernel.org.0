Return-Path: <bpf+bounces-17728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860748122C3
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CCCDB21246
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB2577B3D;
	Wed, 13 Dec 2023 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="THhd50kO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAF7A3
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:23:23 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5e32af77f15so7035547b3.2
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702509803; x=1703114603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVkNB32hd1iHEzvkeQh9LlJbSIwrHIrN9UnZLaDlQKA=;
        b=THhd50kOnuvF+iBDetJfls019ZrA98VLgqPxtWHRzVve2Fz7hX9nDPWSQjWJNbE6i4
         jrzmVd7ZLqVVF6KXeqK6bwjrxbWoCD7BO0pyMkyoK3WMok0d+O9mvscVNLNOwM2KjWIj
         Oj8Ts9Y9W3NjyIEzCqqpEbwamANtjxOS5oSOwxliDL1N8BVT9SS/a2Hk2U0hlklJo+BG
         PMkHTa7LpXDaEytVde9Es7wOmC5jptmjXQfK7b3YraCtjc5qXyThf4OtBRY9hfIt8zTw
         Cf6W4Nr58CocfLSudYsoereYDfL3fEnF+4iEYBY0a51UxF2OaGYylSj5LKE0eZ0w2QDq
         RAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702509803; x=1703114603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVkNB32hd1iHEzvkeQh9LlJbSIwrHIrN9UnZLaDlQKA=;
        b=fw30VluPk/++9TRCpnPPYdcHWj+5r6PGf3cwSYgAGnvC3/kz1lvutB1QuqhKEaQjJl
         KRlcFaduHB6hgpRFI21AKKNZSNEx8Ikq8j2tr4sLG2QU4DcfRdRzPU9Lo8w0If/cL89o
         1tQy6YoSyBHUBj6LQHuj+H88emq5aJElRSAtJv5S0RHutyUBDDG17EHGQGjbdQqeuzuy
         ZFJcNm3r7RtalEM5D6FY1kdqhFQvmge6HbA5q0hALcnDLpLLdTmtdf4J47/L3+4XAFC+
         f7AVfsbIYOJ7j8wWs5lxlCbLOpu1XismH4LqmpkGgfGoESiBteQoCZKhcG3TrxJTagUh
         vX8w==
X-Gm-Message-State: AOJu0YzK8QMU7bLtn2F2PlWRY5jhOWZYLZfYV/Wl1bY7IUUcHTwSuqCW
	hAKU335IA5eGJ2d+ogD09bZEITeUmPxHPqmcwLXTMA4a4+IG7h1bhDufyg==
X-Google-Smtp-Source: AGHT+IHvksdDnxVQ/nYmkyCZ2hwd6b/7WpssRswsT5373vF36zQmClzFML6nBey+PcRwhJLGnLEOWrYopsDgnlNhtGA=
X-Received: by 2002:a81:6c84:0:b0:5e2:9a9c:a18e with SMTP id
 h126-20020a816c84000000b005e29a9ca18emr1956958ywc.23.1702509803090; Wed, 13
 Dec 2023 15:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201180139.328529-2-john.fastabend@gmail.com>
 <20231201211453.27432-1-kuniyu@amazon.com> <656e4758675b9_1bd6e2086f@john.notmuch>
 <ZXKZa4RRmK2M6iHT@pop-os.localdomain> <5c20a29a-ac9f-da0a-01dc-2278d7ae386a@iogearbox.net>
In-Reply-To: <5c20a29a-ac9f-da0a-01dc-2278d7ae386a@iogearbox.net>
From: Amery Hung <amery.hung@bytedance.com>
Date: Wed, 13 Dec 2023 15:23:12 -0800
Message-ID: <CAONe227zBRfcadH22X1A=qRRqNszXFXT0N5Oqt692rcGbsrs9w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf v2 1/2] bpf: syzkaller found null ptr
 deref in unix_bpf proto add
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org, edumazet@google.com, 
	jakub@cloudflare.com, martin.lau@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 12/8/23 5:19 AM, Cong Wang wrote:
> > On Mon, Dec 04, 2023 at 01:40:40PM -0800, John Fastabend wrote:
> >> Kuniyuki Iwashima wrote:
> >>> From: John Fastabend <john.fastabend@gmail.com>
> >>> Date: Fri,  1 Dec 2023 10:01:38 -0800
> >>>> I added logic to track the sock pair for stream_unix sockets so that=
 we
> >>>> ensure lifetime of the sock matches the time a sockmap could referen=
ce
> >>>> the sock (see fixes tag). I forgot though that we allow af_unix unco=
nnected
> >>>> sockets into a sock{map|hash} map.
> >>>>
> >>>> This is problematic because previous fixed expected sk_pair() to exi=
st
> >>>> and did not NULL check it. Because unconnected sockets have a NULL
> >>>> sk_pair this resulted in the NULL ptr dereference found by syzkaller=
.
> >>>>
> >>>> BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x72/0x43=
0 net/unix/unix_bpf.c:171
> >>>> Write of size 4 at addr 0000000000000080 by task syz-executor360/507=
3
> >>>> Call Trace:
> >>>>   <TASK>
> >>>>   ...
> >>>>   sock_hold include/net/sock.h:777 [inline]
> >>>>   unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
> >>>>   sock_map_init_proto net/core/sock_map.c:190 [inline]
> >>>>   sock_map_link+0xb87/0x1100 net/core/sock_map.c:294
> >>>>   sock_map_update_common+0xf6/0x870 net/core/sock_map.c:483
> >>>>   sock_map_update_elem_sys+0x5b6/0x640 net/core/sock_map.c:577
> >>>>   bpf_map_update_value+0x3af/0x820 kernel/bpf/syscall.c:167
> >>>>
> >>>> We considered just checking for the null ptr and skipping taking a r=
ef
> >>>> on the NULL peer sock. But, if the socket is then connected() after
> >>>> being added to the sockmap we can cause the original issue again. So
> >>>> instead this patch blocks adding af_unix sockets that are not in the
> >>>> ESTABLISHED state.
> >>>
> >>> I'm not sure if someone has the unconnected stream socket use case
> >>> though, can't we call additional sock_hold() in connect() by checking
> >>> sk_prot under sk_callback_lock ?
> >>
> >> Could be done I guess yes. I'm not sure the utility of it though. I
> >> thought above patch was the simplest solution and didn't require touch=
ing
> >> main af_unix code. I don't actually use the sockmap with af_unix
> >> sockets anywhere so maybe someone who is using this can comment if
> >> unconnected is needed?
> >
> > Our use case is also connected unix stream socket, as demonstrated in
> > the selftest unix_redir_to_connected().
>
> Great, is everyone good to move this fix forward then? Would be great if
> this receives at least one ack if the latter is indeed the case.
>
> Thanks,
> Daniel

I just want to ack that we are not inserting unconnected UDS to sockmap.

