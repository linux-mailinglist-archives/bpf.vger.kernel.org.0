Return-Path: <bpf+bounces-42432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B001D9A43F2
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 18:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE201C2267A
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751120371D;
	Fri, 18 Oct 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEoEoiMN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03965155A2F;
	Fri, 18 Oct 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269601; cv=none; b=Rxl8ayabBcveM/Xvr2hhSq8p57eKPPf/zrIKhLxjuOZDe1EYp0zmlumMDNHS8KlZp6HDfdvg03mxat8oHU5wqA7uHYfwQtAms3et3wNuRb8lX5f8hCSTZtm4yElnTM43Egre5C4KqtN4DJ5aP1/H2LUmM0nEmeXD8tVj2GQDWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269601; c=relaxed/simple;
	bh=H46ISeiK3W0lqbYv2LwPn1zRPE+sm2SJNIC9+JzX6Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb0fOrV+syz6hvsp1fvyoWIcN6vYT4vPROn6XX6tNmoM8nbcobQWQ0rXFFK82V8E9ld1lyZ/b65ElKt9rsQRwiNdG/p90SLwVbCWmAdBeUvyS9/cwQokXjMQmPKRemmgBB+NOOC3oChPUtIvlkk7cFRujcj8k7xl3TLnEkWoIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEoEoiMN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c805a0753so20530595ad.0;
        Fri, 18 Oct 2024 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729269599; x=1729874399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H46ISeiK3W0lqbYv2LwPn1zRPE+sm2SJNIC9+JzX6Ms=;
        b=kEoEoiMN7oIjv3/w9YT0B6VL9NRT0JvS9WN7HAja2GuxMJBN0ak9yk55zD2mC/NZw4
         fnQGjS5rKeV3GvggPR3u3CV5yJgvSvghwBZh4JgXb4dOkOom1WiAJ5qGYdo+yE1kl9mC
         OUnNsYaMi+nP+ZzS3NMcQHWEFY6okc1nWwvqH4HoU5fBfX3nxKFWzT6lIn52ZpF9EhHu
         mRVcpWP1VGgxvq2H0W/jFaYINEGcw1Wqu0ID6Y1GzqTeTknot7/5JtxlMHgchUe4a6/A
         f+qP+RgKPeKgLUCfcAMsMs6TPVpG5qWd2as1A3wsRNZg6KprAn7ie905FJhVV/b+uTF0
         O5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729269599; x=1729874399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H46ISeiK3W0lqbYv2LwPn1zRPE+sm2SJNIC9+JzX6Ms=;
        b=NNRwmX4Esub0GWbONkbD0Yjcr6zbghZmDS69FPKQG3tMddPMwOlxrjSdI7Trs8AqM6
         0XjY7jB9V84VdKXmhOWBVSYnIS7ad32lfsZGnK5AadKMSgrVDkkaeacz4hEFuCKQKeJL
         5pYTVYC/GMLsr2GWPYO85YOmVETsiVnl06QD2R0KBQ8+qJ2angbwN1aEt13v9jGw2m8Q
         7l6bnPZBR1LA+KN9P2TkpE1xFWAjQvwV/YkL3vSbejdLU2merZhvI6saQJbeIOGbqDIr
         nmWGud84w+Epv4SKw4H+uDcEC6hZcT2YS9jAK9ra8yck72bAht3qhl1xIRfvzdB0g8KQ
         3RsA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Ivl6cFxL6Q3soJVJRISgCTmnx5m8GaFf90RliTOml/3LG6rOXNhVOKhF3fGMXRryofZHPk7U@vger.kernel.org, AJvYcCXaK0YrSYkHWJUx0pDKujHtLyVu0+AuD7nmALk9wOabIaIs31omV1T8AKjIj4hwwjtSWshWvkylQQPNcU1h@vger.kernel.org, AJvYcCXpU7qV+5zKa7o7ZZQCyeFmzleAd2J1zhO2kBhnCA7ZJc6CG0afjQrkQkDLrBThi/Z4vbKJ38b4C90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Voqg7+v8P2Nx4do5qKHxgvK3WWLYEUSyx44v+/F+ACaU47Tb
	ZsupNyWSh+qg4ByoOjxZJ8jBCr5ixDurYYARuTbhlz3ZGmE3q8T0i7NRS2g=
X-Google-Smtp-Source: AGHT+IE/Qr8nmy1eseHm0cw8yDRNQgfcxettWrr8jZ/XrVMu9Jtillxh0kK9TiT5cqWTWnHOvxhzvw==
X-Received: by 2002:a17:902:ea02:b0:20c:8df8:5066 with SMTP id d9443c01a7336-20e5a8f89aamr43516495ad.45.1729269598902;
        Fri, 18 Oct 2024 09:39:58 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a71ee57sm14686945ad.43.2024.10.18.09.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:39:58 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:39:57 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Muyang Tian <tianmuyang@huawei.com>
Cc: bpf@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	yanan@huawei.com, xiesongyang@huawei.com, wuchangye@huawei.com,
	liuxin350@huawei.com, zhangmingyi5@huawei.com, liwei883@huawei.com,
	willemb@google.com
Subject: Re: [PATCH bpf-next v2 0/3] XDP metadata: Rx checksum/GSO hint; Tx
 GSO offload
Message-ID: <ZxKPXdYjwPnpq95V@mini-arch>
References: <20241018091502.411513-1-tianmuyang@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018091502.411513-1-tianmuyang@huawei.com>

On 10/18, Muyang Tian wrote:
> This series introduce XDP metadata functionality, including Rx checksum/GSO hint
> and Tx GSO offload. This is aimed to transfer control fields when processing jumbo
> frames between VMs.

Ideally, the series should also have the implementation of these hints
for a couple of devices and appropriate selftest updates to exercise
them.

For GSO, CC Willem going forward (I don't think I understand why
we want to have gso_type in the TX hint; something like header_len
seems like a better fit).

Please also don't post v3 yet and allow at least a week for the initial
reviewers to catch up..

