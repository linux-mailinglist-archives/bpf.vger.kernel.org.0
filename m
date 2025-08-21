Return-Path: <bpf+bounces-66207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FE5B2F8DA
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD98258274D
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA1F322752;
	Thu, 21 Aug 2025 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yv6pOtbB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCC3090CF
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780426; cv=none; b=lrBzrv+GxOhWkZUyqcnnzZbP4fVfaiTh57FrrmZbElixqQsqxOnj6GCFQpzbBZBPugL4bfdsgjk0omj67tQcsBDMqDzgo/mcL5ZFKUHw8SKqXD1ohq/HHBHaP6q/zraquKCU9/bvB/307xHB46mqF5g67pVvLZ04IjKNy8uJWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780426; c=relaxed/simple;
	bh=T5vFxjCh6b953wcDu7Rlc6rHd98sJerhHHx1XzU9U48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HELtotQK4/mqDhVrnS1lbquoMDH4lLk6wAZAzs9AfdnzGbPkaJvJyQTVcu/mNSXcYroZLlfhXVnidrkWfEM8R9kFsc6uSdJIvfXre5f5r5khVyeuvzs/HKWWBroFUWHwTZVudNpwtWAHd8QPxplLtoPjDUHYICgWKK5R/wDC2P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yv6pOtbB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109921fe7so11265621cf.0
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755780422; x=1756385222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shHdVfFUGDzfHfFpOtcyKZwrJCRaSaLcw+8WiOuBh54=;
        b=yv6pOtbB5XXd2DqAK3srZwLPFEsGqPP8/nSdGY4ODesRvwTch6sP7WnVp7cZzlUrMH
         PlcYLsYV/RI+BnLggWpwUUz+ZlEg/9YExWDroP22aXWAxctFb0kitYWo2lrydObBz250
         OptfgJQolTJ/csXo8D+vpoOoU/gNupjoizan/28NVs+VEHe3/vIHzw6+LAIYtHZopl9F
         +H08hZ/SxsOA9Hwn3LrCKMZVkiaLjq+Fwob3wJi0kwS0vDcHtr4Ra9gw44XyyRl7F783
         IeCVuT48Si4hZi++JieKbAzg8F4gz8hQ/1VR/iMer86hBBhW29jZHAllOSpKzw8yUCrH
         IgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780423; x=1756385223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shHdVfFUGDzfHfFpOtcyKZwrJCRaSaLcw+8WiOuBh54=;
        b=EFyyys2BZSQ3ilMqd3M5mwp3xROdb6psu5BzJ00/3RyVycokZ5344QD8fh9VD8dOTm
         NyHyLKhB+PXl/sw2fhYPGW+3GFcbdkJVTb6G53lhn7jVbT/klx3+P4GWB28dIFkO/JYX
         Qp0N7UgZUdA90EhfP7xCHgsAz4OoxKWOLFQcSU8dWaHD1+joMDtVP3+etkzuxyM8dk3q
         lrJYYPDb2VsES85QOnDu82klukgZaeMb/74ZF69MwlNIEU4x4TMCOuQUx3d8Uxc5iI/F
         7T37KClJK11mimxj7O+hhb0hwNnyj65yYSp3eI5eJmyHabBJQdmYKvdpZuUDguYPY3EQ
         GsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5eKdf36b9PUkHMi9ZaDxTtji4Ppq4vLRQcj9OWnkjKkr4sWMSgXneEamzPfZfX0oL6XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvfoCsZmozP+wsU0oTdFUqVgyh1Vi6sNr0bgm7qAGsqDmHYlJ/
	wZJbKAwhjVpJP3bNVU+bZfbTsVJoeWMfnU7CWjExwxH7jzY2ZRrM3Q8yqf3x9V7K2ebQ4AARdnr
	5Ts/7Neg51f8D6ow0ene/zM/2/CI0qxOwx5YbOgdX
X-Gm-Gg: ASbGncszz86Lp/KLXai6yZ41+KAkh2lJ97m2ueYAFG0PFIOSJ1ABLFgcoxht489UNGS
	8a4DXAKBDfZ9s5BDPHu+4WIX04sN9M7CEWtaob/6Tml1vGFLYJGu24zMCDIAJOCqaoIUk1to8DF
	fEhGmZfPn5jpZYaG5rlewyUTnC/WQRjWFOWuaUC6Hmqax8gAxO3PXaPvYP+eWrG28Btk+nZCM/g
	h483sh3YHg8LEMr/opGto0lyw==
X-Google-Smtp-Source: AGHT+IEwz3FB3i63JUlDizKlKFLIMm5I13VlasfnbwjfR4YX2pffIoWLATjFY51kSeKijUik2nVHlu+EnaAdU+CfakY=
X-Received: by 2002:a05:622a:2b46:b0:4b2:8ac4:ef57 with SMTP id
 d75a77b69052e-4b29ffc0c7bmr28111071cf.78.1755780422300; Thu, 21 Aug 2025
 05:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-12-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-12-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 05:46:49 -0700
X-Gm-Features: Ac12FXz4nWLVsht97nfgNdGgE1s4G1y9w8ArleUb8uD5uJxc6BIM7EIe7pA-Kak
Message-ID: <CANn89i+qYjt45-qO11vu_v=TrK7tn-C=iA5q7bw9YbK-qe5KZA@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 11/14] tcp: accecn: AccECN option send control
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:40=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Instead of sending the option in every ACK, limit sending to
> those ACKs where the option is necessary:
> - Handshake
> - "Change-triggered ACK" + the ACK following it. The
>   2nd ACK is necessary to unambiguously indicate which
>   of the ECN byte counters in increasing. The first
>   ACK has two counters increasing due to the ecnfield
>   edge.
> - ACKs with CE to allow CEP delta validations to take
>   advantage of the option.
> - Force option to be sent every at least once per 2^22
>   bytes. The check is done using the bit edges of the
>   byte counters (avoids need for extra variables).
> - AccECN option beacon to send a few times per RTT even if
>   nothing in the ECN state requires that. The default is 3
>   times per RTT, and its period can be set via
>   sysctl_tcp_ecn_option_beacon.
>
> Below are the pahole outcomes before and after this patch,
> in which the group size of tcp_sock_write_tx is increased
> from 89 to 97 due to the new u64 accecn_opt_tstamp member:
>
> [BEFORE THIS PATCH]
> struct tcp_sock {
>     [...]
>     u64                        tcp_wstamp_ns;        /*  2488     8 */
>     struct list_head           tsorted_sent_queue;   /*  2496    16 */
>
>     [...]
>     __cacheline_group_end__tcp_sock_write_tx[0];     /*  2521     0 */
>     __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2521     0 */
>     u8                         nonagle:4;            /*  2521: 0  1 */
>     u8                         rate_app_limited:1;   /*  2521: 4  1 */
>     /* XXX 3 bits hole, try to pack */
>
>     /* Force alignment to the next boundary: */
>     u8                         :0;
>     u8                         received_ce_pending:4;/*  2522: 0  1 */
>     u8                         unused2:4;            /*  2522: 4  1 */
>     u8                         accecn_minlen:2;      /*  2523: 0  1 */
>     u8                         est_ecnfield:2;       /*  2523: 2  1 */
>     u8                         unused3:4;            /*  2523: 4  1 */
>
>     [...]
>     __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2628     0 */
>
>     [...]
>     /* size: 3200, cachelines: 50, members: 171 */
> }
>
> [AFTER THIS PATCH]
> struct tcp_sock {
>     [...]
>     u64                        tcp_wstamp_ns;        /*  2488     8 */
>     u64                        accecn_opt_tstamp;    /*  2596     8 */
>     struct list_head           tsorted_sent_queue;   /*  2504    16 */
>
>     [...]
>     __cacheline_group_end__tcp_sock_write_tx[0];     /*  2529     0 */
>     __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2529     0 */
>     u8                         nonagle:4;            /*  2529: 0  1 */
>     u8                         rate_app_limited:1;   /*  2529: 4  1 */
>     /* XXX 3 bits hole, try to pack */
>
>     /* Force alignment to the next boundary: */
>     u8                         :0;
>     u8                         received_ce_pending:4;/*  2530: 0  1 */
>     u8                         unused2:4;            /*  2530: 4  1 */
>     u8                         accecn_minlen:2;      /*  2531: 0  1 */
>     u8                         est_ecnfield:2;       /*  2531: 2  1 */
>     u8                         accecn_opt_demand:2;  /*  2531: 4  1 */
>     u8                         prev_ecnfield:2;      /*  2531: 6  1 */
>
>     [...]
>     __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2636     0 */
>
>     [...]
>     /* size: 3200, cachelines: 50, members: 173 */
> }
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

