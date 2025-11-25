Return-Path: <bpf+bounces-75458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FE8C85286
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 14:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A10ED34C137
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10EE3246F2;
	Tue, 25 Nov 2025 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+srcaVn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6F23BD1A
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076889; cv=none; b=f25PIZkXHssEzuJt1uvCOMepk6fcfce4T7gqmRTA+3tr633Rs2BiKhikyJ8HTb6MiJcl3SMnpPuuYygUjgkdjn/iB5RzrKnoQTLudbT9bNV8oKSGHO1nxwppEu3V9ZA9a3eN6FezcrOWn1vNppbkSLEghTZk1xu1u8XfRyJ0t38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076889; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRJSPE3S7oclXCW4n6o924tBovR1+D/3ofcf24294/ycPyCX55yOUKrkc7QMNqoWmBTuPGjfRC8Pwcrh3QU9eOgW//DPbVPW9SpPTknIoyr7SLtcuafWbFSwvGA44HZyKo1PqkQ7qiKDRFCzndoYhPgBCQQN1kZ2rQqzQaLzh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+srcaVn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so7790572a12.2
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 05:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764076886; x=1764681686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=S+srcaVnwTxEdnt0DzwKVDmyzP6pEIuKZQ6KOQhhkFH55Kf3bIyTii4YGzezHnioU1
         BBYkyEt/Q3kpB1JK8DiFDywmJcmjQi195XAudmtDcJJk3/LP+N05sDr29iajWcEfyspV
         ptVKgZGgloWprMleh/CxAuuHEzJ8Y27OX/vai2k9oJSWWM5Q9P3MjO7J7pdcQQ5/y7yF
         GGNGC4rlVIgqYnpeHKVvw/vBKePkVKfBusJmBUTdghkiVwKK9ZI6p3QTyAS5f7vqJgNI
         zC6XBusssXX52DpdndBIPEmPFZDu3VD3UyZem9oLxxR09sUkNGA8vo83e9BuQa0vLBPj
         ISnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764076886; x=1764681686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=jhxqLGCzNssY+g8vGp+CB7TT+VLkUMTHOo3ClcOywtbmwiNev8nudRY0asPJgdFTTC
         2MDI6ZmUDF64DrJ8LWOzX7qKSXOD9D1ifiYEnEvD6aiqObov9uqQ/zCE4kcu8DqRZaXA
         Zl6Ee+atU9us6+Q32PoyFJfsA9SMPDcH0CKkAwG/BZBYHV8HWgYCR4/ZILdl9tDJbNBT
         18/dci01s8Gjc6xNrc7Pi0wHF2FssdLC0CXL6epgaqzmVdQcWPzyAWemSERtH6skVFl3
         alICrczyJ/yCjuvU07pvPwn3Sy8uFt9EqvZTkoJUp2xsWpRfH0er6lnTlWG3gPvKZvkw
         gw0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdKNHLqi8yPvABv2LFYwtA9HlELZBpar5s1gFQ/oigPmVc7aeFjHl/cRxijzQ091doK4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUQAZouBE1qXXHG9dV283XbgoluLj6SxAe9m0qs2gqA0foBpy
	lgZpor8VGkVPiyf7Dgzlf3MOUbw6cAMfnWN1GujV1NG47aycPQpy9BptrG5BJMnvlQZeGKRluKT
	BtNf903CL6Af2d/e+jxVXEYZzMeghGw==
X-Gm-Gg: ASbGnctWYgndoV1UuTt3zioNnuriG1ar3cXcgS5602img6riakrnnAvzneZzYVxkdgJ
	zipXXGWujLcCjxro9na0TBUE+uugWZqNS5rhjjIYKV4LZfKGn8VcSLbEm8zdlgZ+ZnfBpIETFKE
	InrHNyREjjHzosrj2NUL8PoqaRqimy+EV08kus7BJNILPnA7T+44NtEz/q1euvbbB+HvifRLM+f
	0PjE14dORmF9fFB8D3klWfkCRncklnTTteccx4/45Dd6LfxTOmhRI5Ex+c8Q1+Q3m6og1GLPUxq
	JdcKeGP0HEMriLF+N2YAeHj1SDufjv+oxxK+IJIt5LNEBy8v3cjlfPXNkQ==
X-Google-Smtp-Source: AGHT+IFdAjUbTCRihlcnMQbRe3kaTpxY0zS2TJvPnabL+VI06FANQqQrLV6dY7bbefHQ9hiFBD+KK4yE+DNgNHPMVMo=
X-Received: by 2002:a05:6402:280c:b0:640:96fe:c7bb with SMTP id
 4fb4d7f45d1cf-6455469c726mr15216782a12.28.1764076885654; Tue, 25 Nov 2025
 05:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 25 Nov 2025 18:50:46 +0530
X-Gm-Features: AWmQ_bmI0Nc-U-7V1vG_PnxUMzavwAZMXSjJQCtXVqm1t0YM1hU1mPKj8-N19OU
Message-ID: <CACzX3Avd95DD0g1ec5y3Rqhs6fpo0dqcKBScUr17AOHcw_2JhA@mail.gmail.com>
Subject: Re: [PATCH V3 0/6] block: ignore __blkdev_issue_discard() ret value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

