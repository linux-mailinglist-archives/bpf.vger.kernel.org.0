Return-Path: <bpf+bounces-51120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402DFA30544
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 09:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FDD3A5716
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16201EE7D9;
	Tue, 11 Feb 2025 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFMSn8vF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DBF1EE039;
	Tue, 11 Feb 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261321; cv=none; b=JZi1qtjMep8lqHomL7ZoU2Bz96BpIVnTCt8zwXcT1by2clAjL4jxqWTONLFT/9JQouynDrXwcfHbPt5qBGqugbLz2NHQPzJFA86eV2Lad+VbmT/KDpmOlmLiJAFkEE46aDULhFLWAV3y9GJzlO6L/T7Oqtv4Yl8PdT35fswoJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261321; c=relaxed/simple;
	bh=TI6fDrgKY+b/NDlj/UdB9z0v9/To2V5obkuwSf4c8/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEI5QE1uRQDE93IwqbYbsGY22RiSEwMWygUHwYg3sN+ZgXq9FBG6e5VLMSEzfMuoUCHfV/sObcf0Kd+ownYEJuZ90cOxBYO5DXs7OsgHi7laGNlg5VUd2BH2LbezQ3XDXZzmivmnt7UnOqlWcbvElraffNAM8RaMj/36Nq01h6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFMSn8vF; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3cfe17f75dfso49760325ab.2;
        Tue, 11 Feb 2025 00:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739261318; x=1739866118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TI6fDrgKY+b/NDlj/UdB9z0v9/To2V5obkuwSf4c8/w=;
        b=FFMSn8vFOXk3SyEY0EUYMlQvU3y+pgVvjMUEXU9LMNz7eDdxSCB+tBss8yummTUBT8
         2DABw/tJ4fXbGEnIXH6RByhxEX7hagoIS6HLNX0XLnTsd+/1bTFiVyaXsTjKXdoxDz5o
         prgiCNCa9HMo/21TzfB1rGHl5B9RTu0EPCVJmuWVndsUEhBlufncAKeup+NceiAFavhH
         EmfPqdLe95ZDQwGcY5o3/xJn2408ajgChBIPmB3zLYLb/63L/Av+esz8ETHO51qeBW09
         CdzFdv1IjWiS81rmkxogcbTrWjWs2np34E0vFmpy8myb76KWAV8CTb5wEEjK3IvPFjQc
         8uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261318; x=1739866118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI6fDrgKY+b/NDlj/UdB9z0v9/To2V5obkuwSf4c8/w=;
        b=PewXsPUJWKYVh2DFUZ347slSYSJdfYGXE1WIrksI70yRgL/2r5F2Gt74EBOFyqHppK
         Bm8HGBJ/I1hna8AvBe1c8PiN/NHgfmBtdtbSf+NadzoZv1y8dwyTs5FB2554nL/66zvq
         T4t8k/Py7XhSH3IIrDiHBlpSgPEDG1H2x21xU3MoXTshUlvGr33VQsdSMVA5cvt0ag74
         gRawRY/UHwJdN37k8jPx7qkOuQoDwXvsDt5ZsDhPkeTa7+BhrCuP8r/Bqct9AP3SLCqM
         yOlYw4MJGjE8Ty185q3sb9jjIt/Hjs3sFYqHERHvV/CoepaNm+WMHJWjxqffHbLvtFkb
         GH9g==
X-Forwarded-Encrypted: i=1; AJvYcCVBVTTlbbfVYQHvN+hrtK9aclfdEyBvbmQTVvPte+AurNPjyD9Cy+dSnqExlEEx8Cpa0Mbu64i8@vger.kernel.org, AJvYcCVxvrQAPFRRFT/02yC9BCkP00t78K2h9IIIs6+xIUaCw5QfcagYTfPnxVYaFOhnmQKa6/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4l4uIqcJGC3Vly0zrBje5cUduYr67UDtb/c8trxLDaZHktyfW
	5R6i60Su/Dm6sfYX6skx/6viB+K3iTSuhJ0/M3T9LZacVvxirSvadjxj+5QfOpqFGD0h24q5Z+6
	wPe6CCXjfcnwvcYKbDEL/SBqAVo1BVgHwtAZJ5A==
X-Gm-Gg: ASbGncsF7hZWV4mlhcQza+pJvOW4MD9iFK24Ulh9DrNCnoybyH3no3eDmigsZutsmkA
	8HtNMsP99Bs6ZDrhMwLK4JkrCetePjAMNDOvB0qF/BeZnwOtBqNKRGnRXNxqbZLntHIJ1s1DR
X-Google-Smtp-Source: AGHT+IFISN4Tn+1MYaghN7liU6DZ8QD/mF3xm5GjM7HQZg2cRUlZjdRZJGpFh3xSDV+hm9FZvZpj2Api8hh385h3fDQ=
X-Received: by 2002:a05:6e02:3304:b0:3d0:f31:3657 with SMTP id
 e9e14a558f8ab-3d13da2284bmr146513495ab.0.1739261318679; Tue, 11 Feb 2025
 00:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-4-kerneljasonxing@gmail.com> <1ac825c7-e685-4363-ba9d-db0d983ce9f2@linux.dev>
In-Reply-To: <1ac825c7-e685-4363-ba9d-db0d983ce9f2@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Feb 2025 16:08:02 +0800
X-Gm-Features: AWEUYZn6rGNOv8K-2LTL-Ex62_gfXnAZns_M2wwZ6hro5JLT5yuU6jEgmqg_eMw
Message-ID: <CAL+tcoDVGLnoWSSg7TGjnQDvq+etUy6m=XBUBDDmcQZp3GQ1bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 03/12] bpf: stop unsafely accessing TCP fields
 in bpf callbacks
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:34=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/8/25 2:32 AM, Jason Xing wrote:
> > The "is_locked_tcp_sock" flag is added to indicate that the callback
> > site has a tcp_sock locked.
>
> It should mention that the later TX timestamping callbacks will not own t=
he
> lock. This is what this patch is primarily for. We know the background, b=
ut
> future code readers may not. We will eventually become the readers of thi=
s patch
> in a few years' time.
>
> >
> > Apply the new member is_locked_tcp_sock in the existing callbacks
>
> It is hard to read "Apply the new member....". "Apply" could mean a few t=
hings.
> "Set to 1" is clearer.
>
>
> > where is_fullsock is set to 1 can stop UDP socket accessing struct
>
> The UDP part is future proof. This set does not support UDP which has to =
be
> clear in the commit message. This has been brought up before also.
>
> > tcp_sock and stop TCP socket without sk lock protecting does the
> > similar thing, or else it could be catastrophe leading to panic.
> >
> > To keep it simple, instead of distinguishing between read and write
> > access, users aren't allowed all read/write access to the tcp_sock
> > through the older bpf_sock_ops ctx. The new timestamping callbacks
> > can use newer helpers to read everything from a sk (e.g. bpf_core_cast)=
,
> > so nothing is lost.
>
> (Subject):
> bpf: Prevent unsafe access to the sock fields in the BPF timestamping cal=
lback
>
> (Why):
> The subsequent patch will implement BPF TX timestamping. It will call the
> sockops BPF program without holding the sock lock.
>
> This breaks the current assumption that all sock ops programs will hold t=
he sock
> lock. The sock's fields of the uapi's bpf_sock_ops requires this assumpti=
on.
>
> (What and How):
> To address this,
> a new "u8 is_locked_tcp_sock;" field is added. This patch sets it in the =
current
> sock_ops callbacks. The "is_fullsock" test is then replaced by the
> "is_locked_tcp_sock" test during sock_ops_convert_ctx_access().
>
> The new TX timestamping callbacks added in the subsequent patch will not =
have
> this set. This will prevent unsafe access from the new timestamping callb=
acks.
>
> Potentially, we could allow read-only access. However, this would require
> identifying which callback is read-safe-only and also requires additional=
 BPF
> instruction rewrites in the covert_ctx. Since the BPF program can always =
read
> everything from a socket (e.g., by using bpf_core_cast), this patch keeps=
 it
> simple and disables all read and write access to any socket fields throug=
h the
> bpf_sock_ops UAPI from the new TX timestamping callback.
>
> Moreover, note that some of the fields in bpf_sock_ops are specific to tc=
p_sock,
> and sock_ops currently only supports tcp_sock. In the future, UDP timesta=
mping
> will be added, which will also break this assumption. The same idea used =
in this
> patch will be reused. Considering that the current sock_ops only supports
> tcp_sock, the variable is named is_locked_"tcp"_sock.

Thanks so much for polishing the commit message. I appreciate it!

Will adjust it.

Thanks,
Jason

