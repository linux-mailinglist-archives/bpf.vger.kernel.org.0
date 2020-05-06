Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC241C6FC0
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 13:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgEFL5t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 07:57:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56383 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727825AbgEFL5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 07:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588766267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SQDFnlIJbT5ua1JOyFwQCxTImV9nf4dY7BK+J1cBSE=;
        b=fVO5Ddl3bulPKi/gByVHCqOr/l1SwSAzqUlEHpfGrhQt23K29RCOY34MJi8OhOVNwhBIBd
        c4JjscmggfhcN8/OuTQ3fz4JSRJ9PUGXOVXLCdYHvkJA3CZWcm63fc01+BQnyfOKPbzfZr
        e9XnRRqA8t1+zri58pyTGAKlXlGOEm4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-58mQQBoPPLqi-HKpFc81YQ-1; Wed, 06 May 2020 07:57:45 -0400
X-MC-Unique: 58mQQBoPPLqi-HKpFc81YQ-1
Received: by mail-wm1-f70.google.com with SMTP id s12so1090461wmj.6
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 04:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8SQDFnlIJbT5ua1JOyFwQCxTImV9nf4dY7BK+J1cBSE=;
        b=cSQqrT13QcsWg5RLDIw+RDzcoQfAawm+2tE+fR5Fa2/u/QaCVwn6NiciDjhmLeWOWn
         Vw2ojdXwmdPOBbRA9AUsy+wgaiXfN4KmBoaXCdHAQDWXMaKEPzcAEJMf0hOZhGlhVuV6
         Cuk0ZjdRM1ZKzJs2ykrwUfluzpjp2TWL16oZw7j5B7oB++rFCenBMm8yQ2y/niEzrgvi
         HgQfjIU7eTvbDpctNGdrh7TBcc7L6QOxAPfWdOvpj/HKWsirAjrEBmOtgvzrHs0IRtw+
         2kEI6i44+/+iaZS54ngytkX5mRld/8toavSd+NZAJhUrPq3hQI3zhMehncNQf1+nf7sC
         4Yyw==
X-Gm-Message-State: AGi0PubGkhGZhZm7GVoT6p198oECWS/uHtrXCVJ8hwNS763nlm8dHbs1
        q4GsLZ1ZykCunjMfYgEAb8idesmHgXX9Nad4uPBqpTOwG5rZAyGMFvcHvTklPRBKtrP8lHzckOF
        DjjJY62gO7f8G
X-Received: by 2002:a05:600c:2210:: with SMTP id z16mr4188076wml.151.1588766264429;
        Wed, 06 May 2020 04:57:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypKgPL6Idtx8YS8ZSPniHEZVsgz6k4KI77A+1MaVArInKjm4b6YSX9fRi88QPhdunVwvyGecRg==
X-Received: by 2002:a05:600c:2210:: with SMTP id z16mr4188044wml.151.1588766264058;
        Wed, 06 May 2020 04:57:44 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id a139sm1060804wme.18.2020.05.06.04.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 04:57:43 -0700 (PDT)
Date:   Wed, 6 May 2020 07:57:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: performance bug in virtio net xdp
Message-ID: <20200506075719-mutt-send-email-mst@kernel.org>
References: <20200506035704-mutt-send-email-mst@kernel.org>
 <7d801479-5572-0031-b306-a735ca4ce0e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d801479-5572-0031-b306-a735ca4ce0e4@redhat.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 06, 2020 at 04:37:41PM +0800, Jason Wang wrote:
> 
> On 2020/5/6 下午4:08, Michael S. Tsirkin wrote:
> > So for mergeable bufs, we use ewma machinery to guess the correct buffer
> > size. If we don't guess correctly, XDP has to do aggressive copies.
> > 
> > Problem is, xdp paths do not update the ewma at all, except
> > sometimes with XDP_PASS. So whatever we happen to have
> > before we attach XDP, will mostly stay around.
> 
> 
> It looks ok to me since we always use PAGE_SIZE when XDP is enabled in
> get_mergeable_buf_len()?
> 
> Thanks
> 

Oh right. Good point! Answered in another thread.

> > 
> > The fix is probably to update ewma unconditionally.
> > 

