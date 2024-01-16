Return-Path: <bpf+bounces-19688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B182FC66
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2263528F6E6
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70078288B0;
	Tue, 16 Jan 2024 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ji8AQEH7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="vmPReiW9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ngSqDxw0"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87405286B1
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438557; cv=none; b=Ja2nFKrQZD9IgAvB9iz4NvRcxnNZsmP49hjiF0mtttSH+YZTFV7oXQbfW1ufU3O/EBLWyZCZ0y88u+25GMppwpUnqre5lYG5NV5iPy06+v4HYaICuJ3ludiQOjU+/tsSlLaMZ6Pq1VSqKMUM3mc/nW4cJaq6OZTmRlcuq+h2qbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438557; c=relaxed/simple;
	bh=p85Qql6O6J9hUHz3pCIiv8fVqYDQSjagyOsDtEvtVx4=;
	h=Received:DKIM-Signature:Received:DKIM-Signature:X-Original-To:
	 Delivered-To:Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:
	 X-Spam-Level:X-Spam-Status:Received:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:X-Google-Original-From:To:
	 References:In-Reply-To:Date:Message-ID:MIME-Version:X-Mailer:
	 Thread-Index:Content-Language:Archived-At:Subject:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Content-Type:
	 Content-Transfer-Encoding:Errors-To:Sender:X-Original-From:From;
	b=SzbRQkuxP5jLJoNl/Um2OzfG28uH04HvpKtvAEc7faCnAZZDrB+ge05VULE8VGGSzqEFoeZDbQU89YKNtgj/jgr27XSPVuIKmMynFO60b7zBtwMslVJzXhj9TV8J3fDUohDhwEmlXOrmrECVNEzMNvIzHxMvu9gENKYLTXgLyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ji8AQEH7; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=vmPReiW9 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ngSqDxw0 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EA1E9C1CAF45
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 12:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705438555; bh=p85Qql6O6J9hUHz3pCIiv8fVqYDQSjagyOsDtEvtVx4=;
	h=To:References:In-Reply-To:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ji8AQEH7H2u8hbNlqFkVG8eKwCq6RhZ+8ozx/4meK2TsKfq8h86t73+RonjBCgPfP
	 kTUXe7uhkGaZ6DWAuj5GnLTq3ioLPmPkXPJx1Z9M7b7bz0J8k+HPvFnRBgRuZeBvy8
	 d9NC9vvzDjKuf+c8eRcdflNTjo8E9hrIp0FnRBfE=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id BB089C19330B;
 Tue, 16 Jan 2024 12:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1705438555; bh=p85Qql6O6J9hUHz3pCIiv8fVqYDQSjagyOsDtEvtVx4=;
 h=From:To:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=vmPReiW9jsFL1/KRjX+3IGxum9/uacFrwV11S+ALCRFAE2tEcxVATXZagvMXfXaxL
 wbEoGSd0lKXtfygYypQNMMFGJcF3doJNM0R12yLSXGTiP5fca2GXvPCP+j827b6+aN
 1sR/RLWF6SnNiTRpkzM19b8WmiEKCdtXZeIe5jX4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D1386C18DBA1
 for <bpf@ietfa.amsl.com>; Tue, 16 Jan 2024 12:55:53 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J5_UOBTRq_sb for <bpf@ietfa.amsl.com>;
 Tue, 16 Jan 2024 12:55:48 -0800 (PST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id AB880C18DBA0
 for <bpf@ietf.org>; Tue, 16 Jan 2024 12:55:48 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-59927972125so177769eaf.3
 for <bpf@ietf.org>; Tue, 16 Jan 2024 12:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1705438547; x=1706043347; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DlZXQSEO2MSyZETuO+rcAWhvW1Ag1UJ2TRevGaH/dqc=;
 b=ngSqDxw0brv1z6AqYkoYFKrjy6ffn9mryNVuxGxPhr/QKlumyP0nmCB0CsfRBv9QMo
 LpbYGNgja/t60y6YHAMpf6Vzq5y8DgoJH+b9EvnvahLGtnZ9dWZq5XNXRshdEMadF+Wn
 VJi5R8hxMHQ1wlyUGhf2qKeZ97nEfOBHLNtWDlKYRjBsdCkZ7AI/krZA31nwSOpZQXcw
 d0nEVUrmB3fKUASxWRw7ONuPixGmBF7B1lJf4rPSrPWEMQmWSv8uekUSuETpml6NTaL/
 NBlul6U36jNfPIWc5fZJmwqvkchsYMqd2sJXr/MxeE7TnwMEerEyRyM0NphpzKTvdCOD
 m5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705438547; x=1706043347;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DlZXQSEO2MSyZETuO+rcAWhvW1Ag1UJ2TRevGaH/dqc=;
 b=f4/wftvT/IZrtydKfXl0RFaSeGZgvrUtyUZXmOHX/LVnFV+WU9E5HC8wT9lBZD5V7D
 LqH+SF6iCEqaXyfcI0QXdA8np6bchQD8hom/TO/EN4JtYHQJ3jnOehw4iYuKS5yFJFBx
 2v+VKDIDpmoaf6JmGV6GJ09u82uJhxSSyV4fd+1y/GDtlIAQeSgcP4+x9Gq+tpuAgqMN
 cSHNNe4l/2fTe1ovlpMZnQQLy+mNSVa4WG7t+2J1QJF0HTt/q8tam7arkkiCOWfx4n7m
 R+KlQdEfNnLrj2ZLQpfVQ+46y59uNCHslcoRyk5oiZQ0O4zSCEryGtIPOd+N56eKSnt4
 TyNw==
X-Gm-Message-State: AOJu0YyQeJciCzcx8FGrtyOZl1j4k1Gu0SprO4LGR1pxyL/1Rf/K22ng
 xO9qxshM79tK71TkMpSBTyafdsyRiBW37w==
X-Google-Smtp-Source: AGHT+IG5/DVFmUDJZbosCWeDjP+r3KcPmjIWGwF0M9JDdRAfR7XeSlPbiUQBz/rxrO3D51moiCznPQ==
X-Received: by 2002:a05:6359:2a0:b0:176:57b:f71d with SMTP id
 ek32-20020a05635902a000b00176057bf71dmr735462rwb.53.1705438547197; 
 Tue, 16 Jan 2024 12:55:47 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 fi21-20020a056a00399500b006d0d90edd2csm18695pfb.42.2024.01.16.12.55.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jan 2024 12:55:46 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
In-Reply-To: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
Date: Tue, 16 Jan 2024 12:55:44 -0800
Message-ID: <08ab01da48be$603541a0$209fc4e0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkwaT1bS2nmU/D6EzqCIA6r6THFLFH+T6A
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/lke99V8aankL9rvK_-IGrLFJfEo>
Subject: [Bpf] Sign extension ISA question
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

(Resending since a spam filter seems to have blocked the first attempt.)

Is there any semantic difference between the following two instructions?

{.opcode = BPF_ALU64 | BPF_MOV | BPF_K, .offset = 0, .imm = -1}

{.opcode = BPF_ALU64 | BPF_MOVSX | BPF_K, .offset = 32, .imm = -1}

>From my reading both of them treat imm as a signed 32-bit number and
sign-extend it to 64 bits.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

