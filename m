Return-Path: <bpf+bounces-30890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA178D440C
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 05:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E5C1F231E7
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 03:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858A52F74;
	Thu, 30 May 2024 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IE2jKDm0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAFF47F60
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039480; cv=none; b=cqLJoj9B1hXxWjHcCv4AsE+RfqO69Sv2A3Peb8ygcFDrVDjJ4Y3P2mGOJrcajR1INcqK2PJLTVtXj/3eU1raxYTjm/jGnQdWsNSsGyH8WnsYxMVh80siBguWENpTgzUfmKumCxLweXnzKJfaH92AitmT6OIx+F9bY+/yNQ+kSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039480; c=relaxed/simple;
	bh=a+8/wSWGurAyL1xP57PH/iWopIzIysBpD7hmI2WgIbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnCX2QfPVCQhW/B+FAKer6e/40WZEB5jFpCJkz8JOPrIAdM9jicaSdxlmDUvhNQreJlHNtP47A64xQc5MAma0AvQ7bPVkX9eLzfqVnZfrDUkOcwT6Qvq5ZT6O1rS8g9nesuL0OLc+bwzkTz9tL7aeP7QVmqN6+aOXPaYl40Jhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IE2jKDm0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717039478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+8/wSWGurAyL1xP57PH/iWopIzIysBpD7hmI2WgIbw=;
	b=IE2jKDm0bTYZzfm7rdDyeS/9Ld0DzLGee7aiyd++w5/zVrIJ5l/WwzJtl14ydD2ajo3x7v
	9uceTCGB+LEgsSsP9MWEt24o6ZxqM3eG0cneMWW+ZuRZAO1sbotQGuknHV/zYt5tiftEpl
	cZ4+MfqeqRJqAixkBlnXALwaU4PtpKs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-sWa7sg9UOJaZ6K5So2OrcA-1; Wed, 29 May 2024 23:24:36 -0400
X-MC-Unique: sWa7sg9UOJaZ6K5So2OrcA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c1afd956a6so68171a91.1
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 20:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039475; x=1717644275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+8/wSWGurAyL1xP57PH/iWopIzIysBpD7hmI2WgIbw=;
        b=wTqK13rnM7n3QOxCFnqMBwIxlek2pNHPpHCnpctZbq6+QaB2nWo419ZbCgMOHhfupf
         XjMFqNB1OQlvKmh90pkMWtOpllKfrHPYlL7XQbppUqBgzIEumWcIDUsr0z6pkdApp3cJ
         oyxh3zHUWI73gj3nb+79N5W2YLI6un8+jWJgTfB/FAnyZ32MndG4tvG+bRV5JyeIdLHz
         C+SE+BXemayyR0K4ULu0+ts3B4wQIsGNYLK2Xgbz8ToS5fNk7Lf4VUsA5OjKuU2j+Wgb
         RzQzjCPqM0LNYRHYPGlMIBlPHY5iWbxY6NR5rmTj5NHVadv1jjZYwDNo3HfXYC7+FhmW
         eo4g==
X-Forwarded-Encrypted: i=1; AJvYcCXLklO7TSY7KTah2KXe2OQWo86TJjY40YRp7NmRR6Tti2o6mX7Nb1fjdtexce7zCWWqUcTu4CpHfHtXcw+qAzkC5p67
X-Gm-Message-State: AOJu0Yzina0MGxUF6I0GMSRWI+j6Y7hUvmfcOxu12hA/eXkVWMJS2H9f
	Yh8tCSMJ096Jmu1n869dk48YMNbL5RQGeCUg+xKYvvyDgdehbRHwT1sI+M1cUEpG0hzndgHyDxA
	FlwiuFNN+2Fjx6DpATES67ra+7rx1BXawCfIfDlD7KYyICXsMcwZGBTxBnY2tg0NYVJ0cm+Yy/0
	Jta8/A1up+DV/yQYYhefiQPmD0
X-Received: by 2002:a17:90a:398a:b0:2af:a2a:ad67 with SMTP id 98e67ed59e1d1-2c1abc12489mr1001957a91.4.1717039475260;
        Wed, 29 May 2024 20:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnGrS/Tpu0K+sc6kW8BJyvn+oBs4u8ZwjRYuo5hvIzg+1YBpSRBjPcptyuj5g5pFuW4H/euGjPq4Ov1Fodj2I=
X-Received: by 2002:a17:90a:398a:b0:2af:a2a:ad67 with SMTP id
 98e67ed59e1d1-2c1abc12489mr1001935a91.4.1717039474765; Wed, 29 May 2024
 20:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <20240508080514.99458-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240508080514.99458-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:24:23 +0800
Message-ID: <CACGkMEte0SF-Mo=y5knNODpAtB0jra3rst3rR1kGNPZLY23hjw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/7] virtio_net: separate receive_mergeable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This commit separates the function receive_mergeable(),
> put the logic of appending frag to the skb as an independent function.
> The subsequent commit will reuse it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


