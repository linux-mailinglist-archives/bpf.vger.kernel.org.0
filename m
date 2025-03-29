Return-Path: <bpf+bounces-54890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E42A7582D
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 00:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2610C188F186
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 23:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8721F1DE4EF;
	Sat, 29 Mar 2025 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMOAVAfc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8D15442A;
	Sat, 29 Mar 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743292561; cv=none; b=sFaol2QQ27hBAQf+bgtL+f/LeVNk1Hu7znhUh+7rINlzhxz94WmZT6tti1WdYcRRjzv3Wy8dgmxBk+6zzAHeJwYrMdSLdjGWTBY/rP32raKqFnK9bXm7DHx4NweHgqE+EWQv7oUFZyVX5TUUrIjqIZNRxMfh6hsY9t43w/P68us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743292561; c=relaxed/simple;
	bh=y+mR7zE1vMCV2elnnXpNaskkeKBX/s2VCjJWox5HPqk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aReD+hMtlMJ6MplrL7ssa1mDne18axOmaOiEdphrL6AOtAgLxGtdGf224Oi19mUPjcghaZcmCgE5OgfWIct5sNNpb98mBMlkVH5Z/tz+X60EnSlD/sfcV+LR/6Q7KwwUDJx45fhZYtu3DpR7xXeAfE856m6E2iDiXjeB1s+KNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMOAVAfc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22403cbb47fso72310635ad.0;
        Sat, 29 Mar 2025 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743292558; x=1743897358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8XsIkpQwpvOdaXqjVT1BDa0oA5MpylWpI6LFxHUNt3U=;
        b=aMOAVAfc3TsKktHNIO5P6AX//BT6ihgif7J14O2vNqyoRISJlkZ0DxJ8GBGweViPnZ
         lLfb8r/UFGTVYrov7Y6oI/ZZEXhiI0bwPoHDaOrsQ/P8sXXd3noDgGT6E2gfuBr05LVC
         y24qBBvKHY1QYzjJbErl62Qkx8sejtC/9m4S1MzWIRAycod6/jGxTJlNPdIncO0ej/+C
         XfkueyYA9WRpFxILl1/Kn3jiBIQTVFkTkpAFsOsplX0E5I/H7GGrw+u5+Rc4NN3JtXP/
         n0cGbdcYPbalZo2GrYj8QV9B3fIyK2VPdx12DtNa9Ly+AjFYFcEEjYTQa6KALwcd90na
         OHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743292558; x=1743897358;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XsIkpQwpvOdaXqjVT1BDa0oA5MpylWpI6LFxHUNt3U=;
        b=ALyVvCWOELPSYPW3kk52E6Ss+w3Yymz8WR07sE/etMvx1sQtCXNNDA7WmvTwWrREoh
         Rayh1AxAG+cBPPfPLglJyzI99a5wuFl2ioc0jJ40HyVeIbM0LgZK/TCi/nnGxW8AhIJk
         qQZpczhJ1duW2EghXjFmQi7gaRTKyfyAmen4nDTloofqmHBGdm6JF6Zp6smRpZuiUwSj
         6Hai2zyEMnSCewWpmzrvNvSfseHxJUAztxCp3NDy/XRcvX3WtJvzRy1EzUU+hs2AlT8s
         9xATvq+CA7Y7iqIMDIvGo91VQgeeN3tycPL4d/3TybPI2PHXwz1hXDt9JIrgU4OCi/ZX
         IMXg==
X-Gm-Message-State: AOJu0YzUXCmInt5OqQ0ammX75DKAD9+RQmdXQYqRyjYmtRNE2iUL6Iw/
	fLVh5OrFWErVbBiwSK/HkHXXWfHdYV74cSvkAxYyWF3fKNZEGRaZq71J1SSWoOOU/9rgTPdGvrm
	lPCZelai11W+lqtau9FHxTP/8ULmeYdCdFVI=
X-Gm-Gg: ASbGncvslC5f40PM4a6TTDuW87zpGBWcDeVE9cHHIuQ+IWHeMmFo78gyMO29TXupPG7
	1wCOKAgO9Jx+X2yI57LQnj3y8/WM3g4IJbg2oMucRAZ8xtZW+zGLAwC2sOiR+NixKWMUqysXMpc
	cFh7dfAOGRGFlDWu/lRKBNmosBaw==
X-Google-Smtp-Source: AGHT+IG2XbuPAd+yVQNt8lWhrqyuIew2ZStABgIJ6qEcWHC70d6OoJX81UlqMmy0rSDe/SIJ8DSTImF6UjSUDKugULQ=
X-Received: by 2002:a17:903:11c9:b0:215:b9a6:5cb9 with SMTP id
 d9443c01a7336-2292f944a56mr59977925ad.5.1743292558200; Sat, 29 Mar 2025
 16:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xinyong Wang <wang.xy.chn@gmail.com>
Date: Sun, 30 Mar 2025 07:55:46 +0800
X-Gm-Features: AQ5f1Jon9EaKVUXmofbdjWdXbOhfwWbM8AYDAlo2s1gQHxN9Sxur9gp2YTesvkk
Message-ID: <CAKKD2Pow_4GOB4qr9Ms4yiXaMjGX7NeGOKay+x6ohTurQGfLcw@mail.gmail.com>
Subject: [BPF] Question about per-CPU metadata_dst in bpf helper
 bpf_skb_set_tunnel_key implementation
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am an eBPF newbie and still learning the internals. when studying
the implementation of the bpf_skb_set_tunnel_key helper, I have a
question regarding its handling of race conditions.

From what I understand, bpf_skb_set_tunnel_key uses a per-CPU variable
metadata_dst to set tunnel information for a packet. However, it
appears that the function directly references this per-CPU variable
md_dst without copying the tunnel information to the skb, just
refcounted. This may raise a concern about whether the tunnel
information could be overwritten by another packet before the original
packet is finally sent.

For example:

1. When packet A  tx, it calls bpf_skb_set_tunnel_key, and the tunnel
information is stored in the per-CPU variable md_dst.
2. Packet A is queued into qdisc for transmission
3. Before packet A is sent, packet B arrives at the same CPU and calls
bpf_skb_set_tunnel_key, modifying tunnel info of the same per-CPU
variable md_dst.
4. When packet A is finally sent, it might use the tunnel information
set by packet B, leading to incorrect behavior.

Could someone clarify how the bpf_skb_set_tunnel_key ensures that the
tunnel information is not overwritten in such cases?  why does the
example case above not occur?

Thank you for your time and expertise!

Best regards,
Xinyong

