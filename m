Return-Path: <bpf+bounces-77287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C7ACD5D98
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 12:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7039304A294
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 11:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C9314A97;
	Mon, 22 Dec 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2zMOafh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcXpt6J+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8731A80E
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404101; cv=none; b=XGBMNHBxpb8JUtV0W4H5v+Can7bkWzUEXDXkQjK1STfprW24y+fNQ1YgBnSdIGqVMHgp0Neb/moWgx5qbTT2AEXipG7AZenzvb8rDg7nFaJNCOJNXm0N7BNPbvbj3pWAly7DWLN66NyGWWkJEHUnMCnXEbhYEFyeETBserRHnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404101; c=relaxed/simple;
	bh=lYuLP9aLBqUlpP+urfkQzNeqIQUc+NMj+DtIqhGgHuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgM/MHnGPP5m6Fg4m4BeQcw9Q+GD7kMRqJfTEkr9EQBHap0YU2U7fzVIOPQkUUHRldYdQS3+tMM+/0+MNoEj4punhbpbPhw43uqbaGLaorme7n+sOo+KOtgmBoDzOyQbiyYbQBxhMtvlS8zmOx8LvGcSUChgIlqU0uj3hayb4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2zMOafh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcXpt6J+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766404098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OThu/IjAGzkBq+quJ/q8oM4R3JgY1MkWRoPROf/868=;
	b=h2zMOafhSBS7dNcfXcVZSr/csE187+awzbXW/rNl/PQ+XAyQHRh1nTqYEnZgvk3/QGI7gN
	m6MRkw3XBvB75crwIoFaVURztPjEJJGEtgI5uRn2P/If1HAHmoo3HqFqrlvr7NrFBO+fTi
	BnFIzVb4X/5GY/HxqmpMCjutOI52U7Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-3S00xCK1NzewyofVXh8jkA-1; Mon, 22 Dec 2025 06:48:17 -0500
X-MC-Unique: 3S00xCK1NzewyofVXh8jkA-1
X-Mimecast-MFC-AGG-ID: 3S00xCK1NzewyofVXh8jkA_1766404096
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so28152685e9.1
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 03:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766404096; x=1767008896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OThu/IjAGzkBq+quJ/q8oM4R3JgY1MkWRoPROf/868=;
        b=KcXpt6J+SH2JEd02GpQnONOXAPKKleQtqc0k+06N/hKHJj7W+xakWc/YOxaGEF+Yay
         ncPAlBoAltso9V81i0/BQN47TVtvwwTXlEY4Pz0oS7WELECXpbvDmaGgMVEIcJl4VxPN
         7R5AW3FLLKYOjomsAJ+H7FL9SXXa8syrFdBAF6i8QhEFb56u4NCIkSKUyYuur76RRua8
         ejV+jBe6R8kaRVB5uClBpgWaCM1XB2gwcQLu6W+Ra67FHhHMRJVNkHuzLPVBLq6lIaj/
         3mvw+9Fmbei/sBYCbmF2yLteFU+1s1jiKoycpqHCvfvsElM1ETySzaeorNJIwKgUfWyY
         a6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766404096; x=1767008896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OThu/IjAGzkBq+quJ/q8oM4R3JgY1MkWRoPROf/868=;
        b=sI97Hegl2yX4GWo5XEhCbtlS+lRXdlzAS8NCRtcIXdiVTLS7BLAF0Fp65vaBcxEG9B
         c6BryWuFnt879k+4hk0bwSRioKKIcmCj67SDaC6JzOk9gLbFiUcSE5ZrZP3Ql1YnFrVi
         aqCHburJDJNDSHrebdJyLggkACFzGFiAfbNjNCqpPNnWG9ldXBZ4Z2ybJcNzi9c8t7LE
         PdblUY43NwF6AOtMw1S4ijDAPNqut7Eciv/2xiEz2PDzszK7wo+Whc/f9vuSUvdPDNSW
         kSfyBGMQg6bHl42RBPnfRnLBmP7rQ5BDd2SEr5NPyJmoKC9znNgggMOMbP9t/zE/UE21
         qWdA==
X-Forwarded-Encrypted: i=1; AJvYcCV38WlRFtGyHPSiDUcoptKNVNDmWPZeaHNk3hTsxpkQHh6cth9Y9jcu6X49VINBoxXFCz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6r6+iCz+kwG7x/5dkEMYR8vrP+zeOR/gk0ThLIOUEbSfbEby4
	NV+3wAt064jKNUBzWH0pDb0wppmMuntcm2X0zWt4IwZm8EE0RcDV63C1PyS1mXKRqesIYlCoYNV
	BgyIZI2dYPKc2yHexjTSGUndkGhbs7cuueyRSEJeuV6t9EVn8W3nwPG4/nRQ40g==
X-Gm-Gg: AY/fxX7hMdAyHhgFCvwlxKRgtXtbKflUhbBVYY2lw5WGa1/DThhLkxVFEb06e25YBTn
	hJcNsjzKtayJcFBgji4L8gb7Ars+4IFMo5nrgxZwsXPIAkSYpHVelG1Rsa9A+hyYX8+Y1F6f4Jl
	E8/R3wMNKyqT/6KwU0TszlVpZqlwiQ3iYjnrp2irwyvtOP8I2M8K4UBMnlPy2lD2CmkNZwQ4+3I
	aONB3JP271y29jU8NGOakVDxqG8SSJtI+r4Gki9MdU8nx8SwHSnTrBNsH0/PhS9g/b10cJ8CLJ1
	Dqy4HKJqH0LbwujCBfTxu3eFaiVs6BO7mhwUZk2+bCs3T4Z2ruvRVefR7v+SIfYCHE1IXSns7+t
	/d1VicdxXQ89H
X-Received: by 2002:a05:600c:1d1d:b0:479:1348:c61e with SMTP id 5b1f17b1804b1-47d1957d746mr102206495e9.20.1766404095703;
        Mon, 22 Dec 2025 03:48:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXcVpJ9XpL3tNS1cQvFyqPl/3DvxNFYL21GwwhDXV+oXv+RLFBPB9kKJPW2oylc2cqKXev9g==
X-Received: by 2002:a05:600c:1d1d:b0:479:1348:c61e with SMTP id 5b1f17b1804b1-47d1957d746mr102206145e9.20.1766404095316;
        Mon, 22 Dec 2025 03:48:15 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2ebfsm21330135f8f.40.2025.12.22.03.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:48:14 -0800 (PST)
Message-ID: <2ce23c9d-f348-45ce-a2e2-583c45b0fc31@redhat.com>
Date: Mon, 22 Dec 2025 12:48:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] idpf: export RX hardware timestamping
 information to XDP
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: YiFei Zhu <zhuyifei@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 intel-wired-lan@lists.osuosl.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251219202957.2309698-1-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251219202957.2309698-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 9:29 PM, Mina Almasry wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> The logic is similar to idpf_rx_hwtstamp, but the data is exported
> as a BPF kfunc instead of appended to an skb.
> 
> A idpf_queue_has(PTP, rxq) condition is added to check the queue
> supports PTP similar to idpf_rx_process_skb_fields.
> 
> Cc: intel-wired-lan@lists.osuosl.org
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

@YiFei and Mina: I believe this patch should go first via the intel
tree: please replace the 'net-next' tag prefix with 'iwl-next' on later
revision, if any.

Thanks,

Paolo


