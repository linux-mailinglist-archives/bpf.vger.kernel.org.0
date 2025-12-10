Return-Path: <bpf+bounces-76416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C21CB354C
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5250331B9F8D
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6508431A076;
	Wed, 10 Dec 2025 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFZpAmJs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A7225A39
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380810; cv=none; b=X7Zz6Sjf2OWKuAW6sKiPpSym8hpIJigx3rJeI+KlxaiNENWaa2+/78rflyUDcFjVqMx34iiokULSqXRnsKO/L8Ue1IWlFSvKqXjXu2qz50LVy5PF38zRPKwC29QWpgfU/qUB7958dFsN6gSKaoGaAR6ABsaJ6SIgb74AUL/19hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380810; c=relaxed/simple;
	bh=Yx19Cw7PrTxmK2aj7a0su0iOLHk3ekoOT2KchGcwVTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnbd3fH+HIMBk9V3qtAOViwORgKjx76PXBGNbGm+ZhVjKCb85N5XH8e+j8w1bhKAj+vvXOHFSQs0v6nsT5svo2rJqNXhdZDZ0qft+VNCFmSFask27sxcVAK1a/biTueiHnDZBosKzFPYOeuXZOeqNmNahn6ky8TMF3czohn5TRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFZpAmJs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2956d816c10so80594405ad.1
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 07:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765380809; x=1765985609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESuYFpOjYXjLgX7Fp3qymkbq56ElvjhTl63RkbJTEwg=;
        b=XFZpAmJsPEa56/oA8pVgOCGNUOIO4vYGxnUAReDHHmZ+vH8rYPw6VSR09bSvWz9qYA
         TYMpm+sZeK9GTJcA5/UBLCsZLFjerwBBiIGyOgpr6Oj+8vPIk94UUEpjOUhPWiMRWPko
         5IPw8Dr+Xl/RSglyT/JedufffG4CUogff1+pj58Fve+Loo/2EYvK/J2/SYPOWKm9T3gE
         kouG8XyWKIpOnAn+lu3u269F2Dadd19fYhAKMPcBgx1eAP9hVoEC63Su/VqE+GGmN456
         h++4qYsE6PFnHwoboxDsReWGayOoQ9CVv9Lr9zYh2kcov/2pyEVj5yjrEn/C30u3ZxIv
         aXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765380809; x=1765985609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESuYFpOjYXjLgX7Fp3qymkbq56ElvjhTl63RkbJTEwg=;
        b=m93JU0OmEgtmXwT4xhVEKHA5kt0QCx2Dyu/DJ8T1ytcZkiyzIlma6Z7bmQKLgwMknR
         +PJhzc60nyuvM35HLtir9fKCdbtkVrBO+zUZTZmJTpRooiLc7QU06uPwtmfYiIj1zebN
         Eg0alRTLzF0v6CQiWcup+ZuAGLrFKqKvNzQkEG1k2AcrIJRRViwQpJ4XALn8/EDnOeKR
         DBZe1/Ub8kjvwbga57Z7mEg1R3APIRMoMazO1bfoCyZy0GsS4WffofnuO/D6PDfZzRVo
         BN7FHZOqT5lCdBxI0GvTZztCZhTbXjJ9bO/Q3fk5gXE7x177RhoNQSScYVfb2ahRToKr
         vjJg==
X-Forwarded-Encrypted: i=1; AJvYcCVXKKWo/X/RSY6nd+SCupervYB3mwAuwVKtSgVGhTdxE7chnOkZmnqORwdzXrT5ka+tG3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbk5Pp2hid8tYkoO6LswV/Dapry+ur7IJ5z968zaE54i5vO06
	RbZIGtSrfPVV5mpP3D6c/iGBMVcUNv2HS8HNXZPZgFUq8cHc9VMWZPLz
X-Gm-Gg: AY/fxX6Oq/33sC6+9y48SZPldiS6KlDAu0aFrkS/C0KD5u7Wo6ooD+ZxvnIuPUotGMK
	qHvnjyzaRVfXzy8zrtOiTFYFjIv2at3XTmFs+O9Yxj3QO3cBtT8bc8um7MNERwlxSaLg7UmQ1Ht
	bzgUzT2LcqEbV/1+Xw6Rfzy5yvY2tfbv7Xvu372yR/4z/OuaAkxpKjXS5CeQXc+xBn55vSwtBPS
	6DtGWXai1bEfAVcnMhE3mReElvUWNUmvYphwLpj0vbutnlSj+wcYLdNIJTUfJMBoTdqHaA/L9dA
	2QZpLBeFPxMqwr/zeuEG6BkvvypCNVk5/vNnXe2k+5dmZVQbYy1Yt6Ruk5hc8KYE7J69TcqBxOM
	JGzdXOLxgFGZ0z3Yo8dnba9aBZNVsHn2iWYEHFlECVTsXIMs2WLPPo/9z26Gnh/glm4Ze6T8ixN
	Ekl0v0BWdULD6T7P7FXjDoCXDc2+8X7wBEW11mMNtJjS15KY9dzg8RfLHX66J4Ig==
X-Google-Smtp-Source: AGHT+IENrwT2Am+P2vjlTDz+KYOoqnBVC//oOg414tv75XRJNnToBhPmNfWibuLCCf4uNogdSV+RXQ==
X-Received: by 2002:a17:903:2ac7:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-29ec27be899mr30223795ad.42.1765380808606;
        Wed, 10 Dec 2025 07:33:28 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:311c:669b:9c36:4a99? ([2001:ee0:4f4c:210:311c:669b:9c36:4a99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49b196sm191451135ad.17.2025.12.10.07.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 07:33:28 -0800 (PST)
Message-ID: <c83c386e-96a6-4f9f-8047-23ce866ed320@gmail.com>
Date: Wed, 10 Dec 2025 22:33:17 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill
 work
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
 <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
 <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/25 12:45, Jason Wang wrote:
> On Tue, Dec 9, 2025 at 11:23 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 12/9/25 11:30, Jason Wang wrote:
>>> On Mon, Dec 8, 2025 at 11:35 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> Calling napi_disable() on an already disabled napi can cause the
>>>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>>>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>>>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>>>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>>>> work too early before enabling all the receive queue napis.
>>>>
>>>> The deadlock can be reproduced by running
>>>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>>>> device and inserting a cond_resched() inside the for loop in
>>>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>>>> processing the delayed refilled work runs on the same CPU as
>>>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>>>> In real scenario, the contention on netdev_lock can cause the
>>>> reschedule.
>>>>
>>>> This fixes the deadlock by ensuring all receive queue's napis are
>>>> enabled before we enable the delayed refill work in
>>>> virtnet_rx_resume_all() and virtnet_open().
>>>>
>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>>>>    1 file changed, 28 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 8e04adb57f52..f2b1ea65767d 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>>>>           return err != -ENOMEM;
>>>>    }
>>>>
>>>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
>>>> +{
>>>> +       bool schedule_refill = false;
>>>> +       int i;
>>>> +
>>>> +       enable_delayed_refill(vi);
>>> This seems to be still racy?
>>>
>>> For example, in virtnet_open() we had:
>>>
>>> static int virtnet_open(struct net_device *dev)
>>> {
>>>           struct virtnet_info *vi = netdev_priv(dev);
>>>           int i, err;
>>>
>>>           for (i = 0; i < vi->max_queue_pairs; i++) {
>>>                   err = virtnet_enable_queue_pair(vi, i);
>>>                   if (err < 0)
>>>                           goto err_enable_qp;
>>>           }
>>>
>>>           virtnet_rx_refill_all(vi);
>>>
>>> So NAPI and refill work is enabled in this case, so the refill work
>>> could be scheduled and run at the same time?
>> Yes, that's what we expect. We must ensure that refill work is scheduled
>> only when all NAPIs are enabled. The deadlock happens when refill work
>> is scheduled but there are still disabled RX NAPIs.
> Just to make sure we are on the same page, I meant, after refill work
> is enabled, rq0 is NAPI is enabled, in this case the refill work could
> be triggered by the rq0's NAPI so we may end up in the refill work
> that it tries to disable rq1's NAPI while holding the netdev lock.

I don't quite get your point. The current deadlock scenario is this

virtnet_rx_resume_all
napi_enable(rq0) (the rq1 napi is still disabled)
enable_refill_work

refill_work
napi_disable(rq0) -> still okay
napi_enable(rq0) -> still okay
napi_disable(rq1)
-> hold netdev_lock
     -> stuck inside the while loop in napi_disable_locked
             while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
                 usleep_range(20, 200);
                 val = READ_ONCE(n->state);
             }


napi_enable(rq1)
-> stuck while trying to acquire the netdev_lock

The problem is that we must not call napi_disable() on an already 
disabled NAPI (rq1's NAPI in the example).

In the new virtnet_open

static int virtnet_open(struct net_device *dev)
{
          struct virtnet_info *vi = netdev_priv(dev);
          int i, err;

          // Note that at this point, refill work is still disabled, vi->refill_enabled == false,
          // so even if virtnet_receive is called, the refill_work will not be scheduled.
          for (i = 0; i < vi->max_queue_pairs; i++) {
                  err = virtnet_enable_queue_pair(vi, i);
                  if (err < 0)
                          goto err_enable_qp;
          }

          // Here all RX NAPIs are enabled so it's safe to enable refill work again
          virtnet_rx_refill_all(vi);


Thanks,
Quang Minh.


