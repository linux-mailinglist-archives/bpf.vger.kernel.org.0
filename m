Return-Path: <bpf+bounces-33761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E9925826
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 12:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5728D168
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25879142903;
	Wed,  3 Jul 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9jI34nC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F513BAFA
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001733; cv=none; b=PXsTZm+zaGwW5I89stmMkt4HiZI55VDC+5D27cm0rI+Sv0EqjXYESi1R0jFludBMqRt2rHu75gpoxaN5iNiMwuHCS3/kHN1Y4gRQdc970vLHxa2/0MQrTpFh5O4WEC1EfjWRGkYzM1JDzVnGbvN0ntp8O7MsxDNJRD+cw2tCDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001733; c=relaxed/simple;
	bh=xG6CA4O8jt9fOyZKC6Y4HkkHx/QSl+qKJ2lH4xvjsvw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DkN7ka2hI6XTEwTCnXToDKEjyfnQTBKC7h8W6O2qPaZKbggXfhgZxkPUB+0brdqtlLgsGqk/s1Rb+j945sFNzhyW40+qzF6qs74gaRemWd6lg+c0UQOXThWopWYcOi8Uk6GTDmAiBA4NIKzwn3m1kbpNlz4Rknt3ul6gJ61rzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9jI34nC; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0354459844so5103873276.3
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720001731; x=1720606531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xG6CA4O8jt9fOyZKC6Y4HkkHx/QSl+qKJ2lH4xvjsvw=;
        b=h9jI34nC8agfNMAxelN+BJAWMODkncoF6kca8gymjii9OOJ2W+C/cHQaQzRBObB8Ze
         yWypuEKc+Jf+VXr5nNb1chTlYvyuH1Rn53JP7coWW2gnRsp2gysj5Trtl5S79xezTLaO
         MX+OriAaY2yi8x479ChN5HiBoG/k3LlcBpziGBlcLiotTUxKPDbPg0bETfE1iBB0sl9U
         6tVky0tOtsbJjwr0ZnUbLmxnzRKSdzDbx/Kx+aaAxi6TOaAr/IUwfAlxHwR6ozO1L79x
         lL2ay8RIKzsZI+jnkfHpz3M+aCK+2thJmF7FDSZwGMwusD41Yv+RnvjwsSzUOOySLvuV
         iWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001731; x=1720606531;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xG6CA4O8jt9fOyZKC6Y4HkkHx/QSl+qKJ2lH4xvjsvw=;
        b=w9UMNwAlGWwiD4x4cdqpA17DgajNUWw6WXvjLSbzfkGaX6s0+x1pzJk9mE6YPfYQAV
         GCEKWCQ0rdDVbF0KB09BA290bW3/6NjLltoQN0wwtFuFwxtZ/0eAV/R040dVXioKrFrT
         5QBCHaivvixX/1M33vQAaEYRx1vZ0cyNLger3W1GI/q7LHo6jwGqGjJwXoakPMaidrV8
         jAAtP0m4zw0C3nLxBL6jecRU1q7EXx0wVAzD7nhrUdgacKmswQggf06xpNK67fQb1jy2
         dFseWCJBBbbTLWNIyGcfMLobXkqYFXFKhj88IFQGWrpMH1KlIqH9ZwRORiVb4Y9EBve1
         yF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIHuq1kddJ9kqBiOzAwN/YPAi641vqkZD8FawQIcNIiTguyGOsxpMWbFySwLi4uPWxZjEYXpn3nbKyTrDgVRt+Fvef
X-Gm-Message-State: AOJu0Yy7gZMWO3qohzGDywG3zKGWLC5MJQy5SHYlY8p1xLdcsdf0PLvH
	G2SynOnLTGjB5uNVldnnQ943D1Nr9lxlcTebyoeMseCtJVA6dnxszh/e5Mlg9pFzdKilAkbQ+2Y
	EmdOvVYebN92MsL3h03CqtduIWT4=
X-Google-Smtp-Source: AGHT+IFYbttuHMRtjChj4KaeEp60cwbtBXZeGJqFtvZeJ4vMMAs5p29FSE7CEeWy9k44wi2A46aXA3jildmioP2o2nw=
X-Received: by 2002:a25:e812:0:b0:e03:649c:d89d with SMTP id
 3f1490d57ef6-e036eb7871bmr12102187276.33.1720001731345; Wed, 03 Jul 2024
 03:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Totoro W <tw19881113@gmail.com>
Date: Wed, 3 Jul 2024 18:13:57 +0800
Message-ID: <CAFrM9zsE6Y_uScQyT0XoKy_XpP2JvFu1TSJzrYuA8puejzjGRQ@mail.gmail.com>
Subject: Re: A question about BTF naming convention
To: Totoro W <tw19881113@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

More background about Zig. The reason that a structure name is like a
function call is due to Zig's comptime feature.
The actual type could be generated in the compilation time and Zig
toolchain will evaluate them during that time.

