Return-Path: <bpf+bounces-34633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7192F6C7
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91571282FFD
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 08:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E515C1422BD;
	Fri, 12 Jul 2024 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZV7769y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471213D601;
	Fri, 12 Jul 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720772257; cv=none; b=YD3tyc6SVY6+on+BZZrcyCsjgDDWIU7MKal2Z3paHK+InwM04xrDvQo9zU3puB9b4mUwrST8LHnPxeZE+zipPq8EZi5dyvmWMnDCJxb37TLCGUlNaIf6440d6jyPVv4jKnYu7vCn108zqVkb14sZ3N7k6gNJuRrcJjdyj4duNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720772257; c=relaxed/simple;
	bh=g6BQbY2PoskWEZK2+H/k8Itr0ph812HzPCCnqtMZ1Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kn0JQFHm1U2ZIYtD8eLzgz8DJYEcIhLjBwwW8uXkVxCTeE8aRJiU/vuMGrAhPojyuPS9wkopJF2JUjf37D/0Y6B2lr9Y7GRg9148mPs9giZrVZ0kb5gpoLnZH7XekFY5PAg42RyAJUJH723YSrWS5qSo7BJg4WKnYDhBZ77cMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZV7769y; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-78964fd9f2dso838773a12.3;
        Fri, 12 Jul 2024 01:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720772255; x=1721377055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/VNNSVATduh5OiXqB7FDYXYQs1lG35zNpgpLy5fLvc=;
        b=VZV7769yEjy2W5pdmLNClcNXbME7igINR6EBRNmujAhDrSMOhrJXdP5e+CAyPHEfbW
         m5ttY+HR18kLYcQcWj9iLTF1RYJAcUaloah8u0samwsizMdPfvlv/teYxZakEuJon7QI
         ThmRlXJocSeeSdLnDgbLcvICgIKYxdbuwEyvU8N5rb1zgGsAq5j8FSuNW5mRA6+q10rp
         QO+aqMU0Y3d+KVc624gSlJ4I31jOZy4sNvMoC0yU6139UNbDrDplEvyKXo83VMiwT+TX
         JLmLA1WXcTmSaMepeLyDp3/qrCUWKndgAsnKoT/BdRt8LNR+dEg43dAyLi9kYZF6arYi
         Yyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720772255; x=1721377055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/VNNSVATduh5OiXqB7FDYXYQs1lG35zNpgpLy5fLvc=;
        b=GedzzZdV3xz7EcbV3nzcumXAdR08eW2UzjTHhccSjngwLEpa9jFB2p5H1IT/zNcGCO
         kFTxcZwrgdNuehBt4VJIi0ifoXWAoe82/kitZcUPC+jC2SKcIGT8SlQSxsa/+KL8NoAp
         dYgiK40PCQs5kHxaKsUGf0lfyIbyG5DeNl01mZA1+fuG1JU2J8PypnoIBnkWlOX2eRHD
         TgULg5/OnsXGLEguCkt8iMImPWrOeLsIQTmQC3yol5nsyBqFoV44q5UrVDQOuZ2IEZcr
         kn5bxMXGPDVRFykLO8MI3TfJZXIZ5P1QQAfiM31PaR5HBflPFeMcr6C0CIYdv5BoDFp6
         YSPg==
X-Forwarded-Encrypted: i=1; AJvYcCV1oQbhPywRUF9IKNz1zI6ZC6GuT9ro/mBRbaNQn4a+V/6/zdt1BW7ZFBeyiHGJKaTa6d5wz4xk/hqkLvqT9PfEF4t08pEbSCDh1ItI8GlneLLdLTEL0EHL6tJHQn+/F3gBkcdt
X-Gm-Message-State: AOJu0Yx6mqdITLer9K6OGMADZDpY/3Q/Ml7VyKvZv/wqlrVvXGJMmm7q
	+uuuaEAaMMRGHUcejk2WJsj/ZSsIqOiyuaqWz/h9efF2TtcdUfyzkEQVl9GvLloQIQ==
X-Google-Smtp-Source: AGHT+IGmWBuFODJV7ioe217b0PQGyIcD6RxTMMG+fuHy4GLZ88+lqwWk/PMH6SdhzfghGJKAWrZa3g==
X-Received: by 2002:a05:6a21:3393:b0:1c1:e75a:5504 with SMTP id adf61e73a8af0-1c29821bb16mr13156121637.15.1720772255334;
        Fri, 12 Jul 2024 01:17:35 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:60b8:1bf4:882c:1f7a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd41a01asm879730a91.32.2024.07.12.01.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:17:34 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: linearizing skb when downgrade gso_size
Date: Fri, 12 Jul 2024 16:17:24 +0800
Message-Id: <20240712081724.95738-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch>
References: <668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> No need for ternary statement.
> 
> Instead of the complex test in skb_is_nonsg, can we just assume that
> alignment will be off if having frag_list and changing gso_size.
> 
> The same will apply to bpf_skb_net_shrink too.

increase gso_size may be no problem and we can use BPF_F_ADJ_ROOM_FIXED_GSO
to avoid update gso_size when shrink.

> 
> Not sure that it is okay to linearize inside a BPF helper function.
> Hopefully bpf experts can chime in on that.

Thanks

Fred Li



