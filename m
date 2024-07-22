Return-Path: <bpf+bounces-35277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD5093967B
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073D81F22F6F
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 22:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5610D4502F;
	Mon, 22 Jul 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4Q/MvUL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF73381B1;
	Mon, 22 Jul 2024 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686916; cv=none; b=HXpRsNwJCd/hT3qhDHIQ797zFRY68BSLDqiucxOrNdoOAZ29TpUpWPkqX423pbAEFKpEvFUUsdW/pMz+1FKmnXCbGVa07C8O4EXLQoiONaKdJs3j7udwgQCLCD29BUGhx8Zwo9QGFTHEZ+kRlsm5ynXPsmWGXqREVQq3FyN+BR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686916; c=relaxed/simple;
	bh=zEoJmUDtZk6Beg8/fEEDQ83lRgyHVrYhdSWG5CXCTzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dYweCnJ9IcxP7HAeeGfhGdb89g0t/xZKKagwnCnzDtBUdJroKez3xIRzGvpKgog43+OFFajVBk2aZNdmaON8Xf+PLunXtiHwueIqY1gO4CVaIqWOdva0LsQd0BAh/n5OB9VpsOfUUT4sSDzW2ETgk5D1KDaeT1NV29OUOki/0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4Q/MvUL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso94964a12.0;
        Mon, 22 Jul 2024 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721686915; x=1722291715; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zEoJmUDtZk6Beg8/fEEDQ83lRgyHVrYhdSWG5CXCTzE=;
        b=H4Q/MvULRpqMbdXIJRtFGxFoNpGDKtsTBWJRl6nQUIOGCm/NqQOTgVbDkU2/YeGjQC
         8EyhqAKRqn1A1gnigYlVhNPf+KdJCD/gtk5igfhMwUu2yuBG45TiqzKKp5OoQGyZhNfI
         Ec17G/U1B35ga7Jr4yl6CbaNht4cNuSLTx63DG/D7yDmLVOOxK1WmO7enmUdMSRHWd6f
         +YWWmuf56QAMGzbl7o1dDr+W7hjhvIrz/Hn2mGvSRUltpq/yGRlSdun9fcELoGCc40kK
         A4jqB1eZJM1QAlaara8ToapVx8v5PIBKusvPNeyBH/bSZeHvwLkRXLXvuU1r1Y3pWWVM
         k9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721686915; x=1722291715;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEoJmUDtZk6Beg8/fEEDQ83lRgyHVrYhdSWG5CXCTzE=;
        b=iD+l+amIZACJ1YT3gBmPcUJ0x+LCRYEpgA+RZgZXDTcCmIUWA3KaIkmVQRhdgf3nZD
         u0+9jNupoPnxEh8X5msWFTnye5sG2Ya/FFK1PzlgDXjDqkg0lsVU4Pvh0pZHpsJSkJvq
         jtqENT9Y7cZueGogIJXFaQvNBGEwjiThEls50MOWhWR7dmutQlVS0GKAJL3Bc65A1lgL
         DKBYULPDKFXRkmOxTwtVLCPWMNp74dnJWYx9QOXOVjpWcoy1ZE8lDMJg3hS8Xrn69h4I
         4EzfYlZBQDsT4azAB6VxsYB9dBb4+54m6PCRCBP9Rs67x3jKKa9jx8UuhJAxNuk2UIMs
         BoBg==
X-Forwarded-Encrypted: i=1; AJvYcCUelxseCeUCybuap2f1fgBtPMzcdH7fWPkecexgbQ3qvmkJS/dI6eq5Aupc+73nXzeBRu/hwkavQLSs5Q+ikrE5YVyz
X-Gm-Message-State: AOJu0YxWqPTsefwyFlgqVRDoINgwSQ5H1Ag4A2Ii2B+1TIScyqCd2kbS
	GuAYuIKjlZvsrLWM3b53h1Mhjex6ZPtjFSQaur2/KhkgB+NFlqvJ
X-Google-Smtp-Source: AGHT+IGV9RvXnCH6UFby8RweMdenwdQkL+BFUsLmkVkN+u+NSDHZMrejwAUwynHCEiDctx84Wot7Aw==
X-Received: by 2002:a05:6a20:7f87:b0:1c0:f23c:28b1 with SMTP id adf61e73a8af0-1c44f86b056mr1521860637.23.1721686914721;
        Mon, 22 Jul 2024 15:21:54 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a23c3bd206sm2097052a12.72.2024.07.22.15.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:21:54 -0700 (PDT)
Message-ID: <459b8eefe371cb227b729ff89160ec36f69273d8.camel@gmail.com>
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com,  kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com, Andrii Nakryiko <andrii@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>
Date: Mon, 22 Jul 2024 15:21:49 -0700
In-Reply-To: <205c38e28799bfe4b78a5e61fd369d5a5588694f.camel@gmail.com>
References: <20240707222842.4119416-1-mhal@rbox.co>
	 <20240707222842.4119416-3-mhal@rbox.co> <87zfqqnbex.fsf@cloudflare.com>
	 <fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
	 <87ikx962wm.fsf@cloudflare.com>
	 <2eae7943-38d7-4839-ae72-97f9a3123c8a@rbox.co>
	 <87sew57i4v.fsf@cloudflare.com>
	 <027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co>
	 <87ed7lcjnw.fsf@cloudflare.com>
	 <205c38e28799bfe4b78a5e61fd369d5a5588694f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 15:07 -0700, Eduard Zingerman wrote:

[...]

Digging a little bit further, I think the behaviour mentioned was fixed
recently by the following commit:

a3cc56cd2c20 ("selftests/bpf: Use auto-dependencies for test objects")

From 3 days ago.

As the dependency is set from sockmap_basic.test.d,
generated while sockmap_basic.test.o is compiled.


