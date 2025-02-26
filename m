Return-Path: <bpf+bounces-52619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38BDA4559A
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 07:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EC21890BEE
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 06:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC345267B8C;
	Wed, 26 Feb 2025 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZYflIje"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D11E868
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551510; cv=none; b=eSaPe0SR9/JGd0mQwU1Fm65bYwE3RfL9DFm6LjHEvNeSJeaKAOwsGh+fzXd0ZurkrB9YYS3lHWS2V6PRfWQqC9JgYOCo52sZu3hd+pmSam8wmuvZ3AvzY2wix6sjYvUAfEWSLm2hHIFLv7uZwBrQTH9ESD2IQzvCGhbaWfltK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551510; c=relaxed/simple;
	bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tp3aEtpHMPMq3Dgu2P4JXjikZJspeKXor4Qc9/2JNlpodu8CjNwDRAt21NhUxYoOC8X3T0IC7+3EsB0GR3b/9Nb2wiScQaHuZtr7zBihqS7lVKLjQ6unoru27yfT1gi+iezrgUnIJ7rn7CScX7+cRrtlj5XzcKBTd6xcw/aNedA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZYflIje; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740551507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
	b=IZYflIjePBqNgI77fGsryZIFZb7yqtphVmlQgB0G0d8ldKXNUQFlX32CIFy7EYMXdP7tNA
	015sLu3t1XpUY6T8Rv2+Di3ScC9IHZ/mxDnvp9aenBz6Z+j9HUc7HMw0y0fYwAuLR/fjxU
	/td/ezOdtj3yDY4MW0uvpXALLi37OP8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-8XJDX8KDNzWmnTFrSftmJg-1; Wed, 26 Feb 2025 01:31:46 -0500
X-MC-Unique: 8XJDX8KDNzWmnTFrSftmJg-1
X-Mimecast-MFC-AGG-ID: 8XJDX8KDNzWmnTFrSftmJg_1740551505
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fe8de1297eso102250a91.0
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 22:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551505; x=1741156305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
        b=r6SSZ1oO+a6eNo7v282P4gkTmYgF82zxNoKT3xP23AQf2U9bplO33azMlwmhdLsbQb
         2TlmFD72nhY7pISS7tTFDfCrdQhCbYzVYEZUdwzgihTHqdW+psKt4jYG3KSVlxeuiyA1
         rAi+Swz5FJ8UGNdWSPSEm0HZfncKYBYJ8xvVfzT/8ueI7mWxRt6hlfn3NG7DbTVmZkbJ
         eC4uO8Oqk+/UMxbfqylT6gbmCxf7+kFfwYhMJMkegEOgh39BBLMvcH93dcAH2dBJDFAr
         XfTOBUu9gHwM+n9rBm+ygQJf1qOwnxYMJ7QHei1SCtVBXBKiYgRVWp6EvE0gmocL8o3o
         6tkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrwnpD6lCuwkMk5qjoCKGcTN2MxosUxrKZt5fKdqirWOtpCX0sCvPm16p7c1ZZn72eiP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kWGeYlZwFS9ssPhe+RCTwSUb657+DcjCfZA51BNekYSHUjk7
	8qn6ThL/d19MCx41fiAepukndYDhX7miUecOGl2Kts6ULOcUs2l126TFEYIOvmb8RUMBAHpoG2q
	uh90kMYWJqlTNgZVBNH0dwCleu2l75IF9Z+/Rb/Hnx4Sz+Km4HT24zX7oIwlEdAVvyyUk3nKg7l
	ju1WGpz6sd25cQckGgvdJMQrO/
X-Gm-Gg: ASbGncvU3CNz9ZL5TL8leHQR8gp5SlpcJII+yH9HdyHEoqn7BiI7U59HyZWmoZQMzqj
	cLAz5dqWW/22fvFftWHrMfWmoMZNLc7d042JXGapDmpswizihuUob09yRPfU3GpeLEPIacZXcNQ
	==
X-Received: by 2002:a17:90a:c105:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-2fccc117c76mr44400166a91.8.1740551505311;
        Tue, 25 Feb 2025 22:31:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgJ5uK64t8Qtg0HyTf+eyJQk/RcSifCuXdoxenxtpslxzpKs5bezA8wPuv+n2H82B3bP4YRr7ay+RtusUhlC4=
X-Received: by 2002:a17:90a:c105:b0:2fb:fe21:4841 with SMTP id
 98e67ed59e1d1-2fccc117c76mr44400139a91.8.1740551504951; Tue, 25 Feb 2025
 22:31:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de> <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 14:31:33 +0800
X-Gm-Features: AWEUYZnqLtwn7p8rdsbyWWPnxjSlaXy5DuVDq_eYBndkM_qofe9C8RC5AoEl0-4
Message-ID: <CACGkMEuoaqKB-4rs1QgsEU2rDn5s5GTJaL6jOiFj_TDSF2pC0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] selftests/bpf: move open_tuntap to
 network helpers
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:29=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> To test the XDP metadata functionality of the tun driver, it's necessary
> to create a new tap device first. A helper function for this already
> exists in lwt_helpers.h. Move it to the common network helpers header,
> so it can be reused in other tests.
>
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


