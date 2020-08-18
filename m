Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD9247C4C
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 04:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHRCpC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 22:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgHRCpA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Aug 2020 22:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597718699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byIIg0+hWGx+CIQdfvHdI9GzTtVaRLGpZ3kdt86FSFw=;
        b=fAfqtt8l4UsS2fdZzZ2XZ6A3xortXTOwJug72a102+7lDSh3vkj/wTOYvTo4kMDKitjInQ
        5ezsvRK/tf6C2OXCx4nO1kk43mDfXuaYLOliE8zXpIe6Kl5Mj1GgljQty8B8cyyOOBJ7TY
        Nb5B80/mJnom9GTVxk/daDeW+qaBPmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-B0Fd9nOeN1Oi63nCENRJlQ-1; Mon, 17 Aug 2020 22:44:54 -0400
X-MC-Unique: B0Fd9nOeN1Oi63nCENRJlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 371CC1084C84;
        Tue, 18 Aug 2020 02:44:53 +0000 (UTC)
Received: from T590 (ovpn-13-119.pek2.redhat.com [10.72.13.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CE54709E4;
        Tue, 18 Aug 2020 02:44:45 +0000 (UTC)
Date:   Tue, 18 Aug 2020 10:44:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 0/4] block/bpf: add eBPF based block layer IO
 filtering
Message-ID: <20200818024440.GA2508858@T590>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812163305.545447-1-leah.rumancik@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 12, 2020 at 04:33:01PM +0000, Leah Rumancik wrote:
> This patch series adds support for a new security mechanism to filter IO
> in the block layer. With this patch series, the policy for IO filtering
> can be programmed into an eBPF program which gets attached to the struct
> gendisk. The filter can either drop or allow IO requests. It cannot modify
> requests. We do not support splitting of IOs, and we do not support
> filtering of IOs that bypass submit_bio (such as SG_IO, NVMe passthrough).
> At Google, we use IO filtering to prevent accidental modification of data.

I understand both SCSI's Persistent Reservations and NVMe's Reservation
may prevent accidental modification of data on shared LUN/NS, but they may
not work in request level.

Could you explain a bit about some real use cases with this filter
mechanism? 


Thanks, 
Ming

