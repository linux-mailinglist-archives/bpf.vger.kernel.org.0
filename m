Return-Path: <bpf+bounces-18764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F55821AB6
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 12:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFF7283020
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 11:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209BCDDD3;
	Tue,  2 Jan 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKJh7KkI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5FDDC1
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dc025dd9a9so3418491a34.1
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 03:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704194059; x=1704798859; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SfCvLzWHwEg/cgF2RlSHc8or2lN8Ibar1HF6+/VYM70=;
        b=CKJh7KkI5o9fBZxLBJ5zlmXLGAB9yl0iSNPhebRjReQyqN1KrWD7sHVl70Efwb9a9X
         Y+RmeQ+UBuuKPQfcKE/EwyA6WOtWxpXeW3zL0iL1dLjyveQXyRsm95/rfYSD5HdpOyZu
         q8cCWPvPHqgOofWY18TDoRgIOoN+IiPpSbFywlvX1zjzwocx9SlTK/A1HnCcxFP6P3Y5
         pl8qrGNT7d/Xs70NjREVKSSZI0Jdl0eNV7eHDZrY3gcUaZtUqvOM05DlKBL3cIccykA8
         HUVlfy2LGRR/pmz/KVGud8CmJ2MXpJi6xh4SlCD+o0QRhQYDnYfOJo5B3ls/yIN6FTON
         wuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704194059; x=1704798859;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfCvLzWHwEg/cgF2RlSHc8or2lN8Ibar1HF6+/VYM70=;
        b=NqnGkzsb+G0T5LBDEWG/gdlqPWgfMd2fEJC8k/iZnKsTyHHWAjrT0G4PF0r/34mwxb
         1omUMjl0uUERwOTLmEJiE3zcz0UyV7ILSDKVJhvrU8XyFMZb7dv1WahAU71laSelZWOg
         coicvuHFozoLDE3YfiMVshaYxlwi6dhKWtK7/1+qs0HHhRL6yugMf/sR7jryz8W7frcT
         zzeZDHs71Ghl3ElyEedFkXftF/sjwPF5qfWDgMSfylluI534mrCF1MyyXpED1hVB+79h
         dyjf+YDLQb1HlhbRX6GeyXRiDjPqTKguwFmk58fOj7+gQUZfwTU3DL8q18Gn9mNIWzyN
         I1yA==
X-Gm-Message-State: AOJu0YybFO4QUO4VMGiNL6GNNwegcnC1eb87CASAKC7yCJ/8JEKL2UxC
	RnFqB7UXlxsvW/qHQxQXCrq0yLA8VWOrHpsDYoJXeHWZZ/E=
X-Google-Smtp-Source: AGHT+IG/mL69qdEzdGTNfacOqXntWbyUM6ZpmeUbsRS5HjkTc4df+fMgZHHp1pWfrP3X9i7biPTCR17gEvxslDQbOoQ=
X-Received: by 2002:a4a:ab86:0:b0:595:e396:2ea8 with SMTP id
 m6-20020a4aab86000000b00595e3962ea8mr171611oon.12.1704194059242; Tue, 02 Jan
 2024 03:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: P K <pkopensrc@gmail.com>
Date: Tue, 2 Jan 2024 16:44:08 +0530
Message-ID: <CAL0j0DFrjP=y2TMCmsFr7yYL+dxZ7oJTc49_1WUj-YvK-78kMw@mail.gmail.com>
Subject: Need help in tracing nf_nat kprobe
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I want to track the Source IP for outgoing packets which are
masqueraded via iptables in Linux kernel while routing the packet to
destination.

I was using kprobe for nf_nat_ipv4_manip_pkt for the same but which is
not working anymore in the latest kernel 6.1.66-1 onwards.

What would be the best way to do the same in bpf or kprobe?

