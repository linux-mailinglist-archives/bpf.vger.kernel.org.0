Return-Path: <bpf+bounces-21643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C91184FC7D
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EEE1F25B24
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D6481AA5;
	Fri,  9 Feb 2024 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYciGQNZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741B7EF06
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505213; cv=none; b=ngBURcU9Fa77Cb9eaaa/blz8zupUF4XbCm0dhZi2gsK9KYc2uS6NhSz8B88C2re/gnmeX9pElmjTfwFx1GjV613nFUPJq1y74AeQ9nRbeLKXTL4qgsOSYLfmezFPpZf3o47Ndt5AAHHLh/m4XzM22kdTQOuEu9ZnOyxgkm6D4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505213; c=relaxed/simple;
	bh=/xxA9aj9+moZRyZEhdH5ivAhhjreVAvaHdT1JeQN6l8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E8tnx+gd+cBuPXGIcs2hvU9Dcr94KWF1v+90RogXZYHdNHQEqLs8THi6sVy1HlP/qvHWmLN4U8MBk+Xmm9M2vh30MLnpZyBRnbTbs7NAvjjF8DHR8YbMdq3DGi6SJxDy/jZvWeUf7tep/vXZIlOSGTeveR77prnab9+BMopJfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYciGQNZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso3109334276.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707505211; x=1708110011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8N2lymSXP7FC6HVuiyphIGsQpdTBuCsjr2jpaDS1PFU=;
        b=aYciGQNZemh4mD9W/6DUgVrI6hBdMA9cxErYqkpFwLDOkpNZ5ARsvSle+p2hOh0XCc
         rFW6WtBfhlBdfG+3osYVScXGyUmZAMEL9q6dHJgwUgGxwBmwNA0WeFUheFXGo33Hicfe
         5rWdD0N7io6lq5fE72FVT3ZKPYblOU9JSlH3Rc30H//dnaxCIf7SomyCmQYBRBOY63pv
         ni8UDBQZCt4GzC1IKt4YDTTi6dT5ngxvdq7KxWVZVs1Ok403v8XL5m4hruooDLqxcqUA
         vp8M4DHtDYmd2JCxkSmaCl1Pud++cCGkqOqJeWTxOF4sckMXvn/IK28bOjo1TdwWmIKX
         Q/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505211; x=1708110011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8N2lymSXP7FC6HVuiyphIGsQpdTBuCsjr2jpaDS1PFU=;
        b=nAikuZWh2Mu2pqbrONUGjnmO2sKjXd85DaoZb8PUToHD1ADG82RWROxpIcuN3stmZM
         1hddc/1BOgkz8M5CHaMw61kFbioV0SBXX9stHjurPG1cBJxquZ60lTDWG3Ax+w+aG6az
         0KM2g1JZONBqu7lonJgME2lGiuw405t+6HWY2EHepzWG3MkIl8LKaaaoATPs0p8wUzof
         4OCwyV9p3t/twr8J1rC/DBK9J5bGEsQ05cSFAh4EShlV6KKdrovcHp/+wyjCFuZ1ge6O
         6jWD6Z/tpMLpp2WBzPT3VPLytDyVdvlJg3Xw9VXPxtaRNn9KpaYLf6JVpF6SJruBxjcD
         PBOw==
X-Gm-Message-State: AOJu0YwIZw88cCqppM6aCGG1cjYnylT3E/mxjO3qzkeDwepSFfOHBQKF
	+w9EEh8szM/jHdHLIYR76SIsKKgsWfGFWj5FYaRGvSQ+c5o0ipU1kBVCLwpK4qT6og==
X-Google-Smtp-Source: AGHT+IH5Q0IlUbPlUBMLY7u08YFFuSOUvpr1JP/Ap/gH8ZtyZ66trBmIwIQNGyH5+xgLUW2XPLj1khQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1002:b0:dc6:e884:2342 with SMTP id
 w2-20020a056902100200b00dc6e8842342mr1088ybt.5.1707505211418; Fri, 09 Feb
 2024 11:00:11 -0800 (PST)
Date: Fri, 9 Feb 2024 11:00:09 -0800
In-Reply-To: <3htegzrugq4xwlizizsaku6g2pzwhndcnxxxmji4fvblisiuro@icvcsa3mky3w>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ngc7klapduckb67tsymb3blu2wlmdsjo4pa4gbaivgxezbwzxp@v7akqu7gbwl4>
 <ZcV1GgitdBUIcKJT@google.com> <3htegzrugq4xwlizizsaku6g2pzwhndcnxxxmji4fvblisiuro@icvcsa3mky3w>
Message-ID: <ZcZ2ObDxRwZ-hKLb@google.com>
Subject: Re: [PATCH] net: remove check before __cgroup_bpf_run_filter_skb
From: Stanislav Fomichev <sdf@google.com>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, thinker.li@gmail.com
Content-Type: text/plain; charset="utf-8"

On 02/08, Oliver Crumrine wrote:
> On Thu, Feb 08, 2024 at 04:43:06PM -0800, Stanislav Fomichev wrote:
> > The check is here to make sure we only run this hook on non-req sockets.
> > Dropping it would mean we'd be running the hook on the listeners
> > instead. I don't think we want that.
> 
> You are correct that we don't want to run the code on listeners. However
> the check for that is in the function this macro calls,
> __cgroup_bpf_run_filter_skb (the check is on line 1367 of
> kernel/bpf/cgroup.c, for 6.8.0-rc3). The check doesn't need to be done
> twice, so it can be removed in this macro. 

Maybe we should instead remove "(!sk || !sk_fullsock(sk))" check from
__cgroup_bpf_run_filter_skb? BPF_CGROUP_RUN_PROG_INET_EGRESS makes
care of all those corner conditions. We just need to add those checks to
BPF_CGROUP_RUN_PROG_INET_INGRESS.

Let me also CC Kui-Feng, he was touching this part recently in commit
223f5f79f2ce ("bpf, net: Check skb ownership against full socket.").

