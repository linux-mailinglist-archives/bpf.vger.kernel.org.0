Return-Path: <bpf+bounces-42850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 246869ABA62
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 02:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD573B231B6
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 00:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04674C79;
	Wed, 23 Oct 2024 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIIyryBC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6134A1C
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642151; cv=none; b=kPuE1iwkWgsL5UHEfi5PXn3DhERklG49qELyJk2Maa4egRUy4yoxkhtxcB64+i3RXMMAnxbmbOGifXa9E+WYTScH0aUHw0gTnqwKZzGFASZtUC3Wx3H7AB1J8fs04idQ98iG6Mq/gBKR3bi7pvOQkt0uSwLCyQxEocLi7MtnOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642151; c=relaxed/simple;
	bh=Wc0i98wyI7scmghmPEBC/D7k6DASIr7S5uM83+PBpag=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WMaN/cv4uSZta1BxuiK50GNS0YudADbdCojk69gE1I5NW3kNTK7Rw9ER5cNAcDfkBc5vWQc8K7/W0C9QXUH5Jh/afegvIOFEmjlfYsEAMVaTOEPa8Az09KJJAivwIDesIHiNqGuyAWw+btuzDBGO0TldnO1wvNdF79YwTJjkxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIIyryBC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so4411384b3a.0
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 17:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729642149; x=1730246949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wc0i98wyI7scmghmPEBC/D7k6DASIr7S5uM83+PBpag=;
        b=nIIyryBC61SuVw6h3J/BvWnoycBdTkEyyxCsTJ5roazgC9yMxcriNHp/88YALwosml
         7FxISE5oDQikXs9Pr1lbR0GAWGyVbzfko5MOu6/YNVyrzUFk1oLFWOUTFDuKAZqFnEHV
         25qWynk5VAk1rX8kmqZ49hgHad9+fXYVZx+tgCU+83L2y4Ltjbq+Bdv6FaSlBGo2ecur
         G7ty7vZaKXDW2b+lGnZrH2THOEUtPY80DDXYJ0hKn8kFX4HIoUHS9Sev3ybs115VYfkN
         MEu/iQCS+licj3lWBtrWPyCG4IzFpIC1IheXGmfsB+nZ+vpb0s0uAEt/GXVvc/Xgwyk/
         2fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729642149; x=1730246949;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wc0i98wyI7scmghmPEBC/D7k6DASIr7S5uM83+PBpag=;
        b=g5dxNQrBg7SMqAlNJzjlXdoH9fyHOguJON/8uBVck2/LzLG3YfWJxyfmyuL2W2edL6
         jfmFs1hca6hA4eZsOJOYupxFFKpxGLLiRJUxXcHxRllhLdvQOIN2bDHubPL4iWLc+3Cl
         hnb1O8xEc4lXscvaDJIwbuuNCOCjzerBOIPAW49xZaJYhtYclgJBeYAxNziv/SXZgDEz
         578qF9e6AIZfhlUvY200sYAV/uZDOoiig/3CytorhtmHdneoE4UY8L+F2G6yuyf/YW2b
         iCPFhFsqEpyocBrRF1OujDVdTDYFK5rWJi053IrHKx76kQpWxtWFbf4t/oXse1AlWCrq
         M6BA==
X-Gm-Message-State: AOJu0YxJTN0vB1EK1QmqQw3DTZbphYQN1XRBSnI80ptBWFBAOHla7fzs
	0QcTC2HOrd6x9Lqyz+7iTTnzq1CdT1eTkX7gbbfR4lOzSPcKwQDBs1AGiAkoDlXXLPvWfimLdwF
	OVk2jJs0zyWPiTFIwJcJme6qm93Iowg==
X-Google-Smtp-Source: AGHT+IF0zjNn2lSzv0kPzVDV0DTJb/663VEFcFNp1zk5ZxXWAeI7SY2VXtmCLx/ESLVfF1BCjxRSl0NlgwtuWeXI238=
X-Received: by 2002:a05:6a00:2da4:b0:71e:21:d2d8 with SMTP id
 d2e1a72fcca58-72030b998famr1272235b3a.7.1729642149083; Tue, 22 Oct 2024
 17:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Oct 2024 17:08:56 -0700
Message-ID: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
Subject: Questions about the state of some BTF features
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hey Alan,

There were a few BTF-related features you've been working on, and I
realized recently that I don't remember exactly where we ended up with
them and whether there is anything blocking those features. So instead
of going on a mailing list archeology trip, I decided to lazily ask
you directly :)

Basically, at some point we were discussing and reviewing BTF
extensions to have a minimal description of BTF types sizes (fixed and
per-item length). What happened to it? Did we decide it's not
necessary, or is it still in the works?

Also, distilled BTF stuff. We landed libbpf-side API (and I believe
the kernel-side changes went in as well, right?), but I don't think we
enabled this functionality for kernel builds, is that right? What's
missing to have relocatable BTF inside kernel modules? Pahole changes?
Has that landed?

Thanks!

-- Andrii

