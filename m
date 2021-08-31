Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5943FC9DA
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhHaOfG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 10:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238327AbhHaOfA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 10:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630420444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6PmT5XJD+8h8skjkZI3qWWXkCH+r4hgnl/yZSPi7Y2o=;
        b=HpoMIqo0uErqUStH7ZrQMh8ijkNteEHgPls0mF1qNNT76WtY7QKUyAL1IzwunFMh1849Pn
        orwO+VRwH/1mwfZGObM7c17c2Dvs5q9+MCmJyqultga0pQG8IqgBARUIf+bkUOif6+lYTD
        hjf0B8at2+eONV46G2OGDHppR5YB5H8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-o979AFxMNxKyH9cMUPSOLw-1; Tue, 31 Aug 2021 10:34:02 -0400
X-MC-Unique: o979AFxMNxKyH9cMUPSOLw-1
Received: by mail-ed1-f72.google.com with SMTP id z17-20020a05640240d100b003cac681f4f4so3895405edb.21
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 07:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6PmT5XJD+8h8skjkZI3qWWXkCH+r4hgnl/yZSPi7Y2o=;
        b=jzAKO6KDWqIfrkSoFCzEbjLSe884RF56xOu+kBvuRRWo+KmHpK9SjKZkXRtLdtVDVA
         XYqXtZ28FhfT7cPeBr663cyj+HFpDUA0OI+AZznwvgVNdQsFS1Wf22h89owQM6Hmw7Ip
         lj94+GoCJ8+FoslXSyOsnFVMBbFPtvmjpoaol1nJk7oZKz6qjbOleRbJ2kTf+z5snGBJ
         a8Hz9IxV3vV94A9X33lbcCWu47TUz94faAVkwcGQv+CRfqmdJ+BlwI0WAzsshaK4SKOD
         t8ZJLhp/I4j6w10KouVIU5MKRVfkXSHzQa87/FWjzCRtCJbY3yqMLl8nMa2egc6un9GP
         Cy9A==
X-Gm-Message-State: AOAM531v0KdDoJEwdamRjkugR7+4fzaZkmkteLyagNPo4rlkwHIH1wtb
        /n08p2MnjspFhis7dy1/AgvHebo+jWq0Xvh57x0k+6myujQzj8w1I2SBcjcGBHuvwWPwjbGe48p
        jUkXkMbZh8qpg
X-Received: by 2002:a17:906:1913:: with SMTP id a19mr31557125eje.390.1630420441148;
        Tue, 31 Aug 2021 07:34:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzjjdwiOd8AeTnBC2TXxLH1EhvIr4UtSGSCDv5ZFm6H4uv3KIhAXZlHdfrPICpWzNoiNhPsw==
X-Received: by 2002:a17:906:1913:: with SMTP id a19mr31557113eje.390.1630420440965;
        Tue, 31 Aug 2021 07:34:00 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
        by smtp.gmail.com with ESMTPSA id q9sm8369501ejf.70.2021.08.31.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:34:00 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:33:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHZpcnRp?= =?utf-8?Q?o=5Fnet?=
 =?utf-8?Q?=3A?= reduce raw_smp_processor_id() calling in virtnet_xdp_get_sq
Message-ID: <20210831103024-mutt-send-email-mst@kernel.org>
References: <1629966095-16341-1-git-send-email-lirongqing@baidu.com>
 <20210830170837-mutt-send-email-mst@kernel.org>
 <bbf978c3252b4f2ea13ab7ca07d53034@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbf978c3252b4f2ea13ab7ca07d53034@baidu.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 02:09:36AM +0000, Li,Rongqing wrote:
> > -----邮件原件-----
> > 发件人: Michael S. Tsirkin <mst@redhat.com>
> > 发送时间: 2021年8月31日 5:10
> > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > 抄送: netdev@vger.kernel.org; bpf@vger.kernel.org;
> > virtualization@lists.linux-foundation.org
> > 主题: Re: [PATCH] virtio_net: reduce raw_smp_processor_id() calling in
> > virtnet_xdp_get_sq
> > 
> > On Thu, Aug 26, 2021 at 04:21:35PM +0800, Li RongQing wrote:
> > > smp_processor_id()/raw* will be called once each when not more queues
> > > in virtnet_xdp_get_sq() which is called in non-preemptible context, so
> > > it's safe to call the function
> > > smp_processor_id() once.
> > >
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > 
> > commit log should probably explain why it's a good idea to replace
> > raw_smp_processor_id with smp_processor_id in the case of curr_queue_pairs
> > <= nr_cpu_ids.
> > 
> 
> 
> I change it as below, is it ok?
> 
>     virtio_net: reduce raw_smp_processor_id() calling in virtnet_xdp_get_sq

shorter:

virtio_net: s/raw_smp_processor_id/smp_processor_id/ in virtnet_xdp_get_sq


> 
>     smp_processor_id() and raw_smp_processor_id() are called once
>     each in virtnet_xdp_get_sq(), when curr_queue_pairs <= nr_cpu_ids,
>     should be merged

I'd just drop this part.

> 
>     virtnet_xdp_get_sq() is called in non-preemptible context, so
>     it's safe to call the function smp_processor_id(), and keep
>     smp_processor_id(), and remove the calling of raw_smp_processor_id(),
>     avoid the wrong use virtnet_xdp_get_sq to preemptible context
>     in the future

s/avoid.*/this way we'll get a warning if this is ever called in a preemptible context/


> 
> -Li

