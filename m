Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7641C6AE7
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgEFIIg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 04:08:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20010 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728602AbgEFIIe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 04:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588752513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CBWxp/RqrAZHRhIdtBhb3xri0XLzwh+Ch7QU+ftNF34=;
        b=X5aij9Dcg2c93UiXjCx3F/VgGLUlK7pOUCYpH/bYM3QYiDkBSGh0H+oceIGQiF7O03vaEV
        tAM8Jk8uRuPne4OoGVMRylpzKyTsqwfgTWG3njDnYngWMNqaZ2x5ZG5UaL+8YXkyqaIw5v
        GGwZCsCSe+cvN9YtNFcYgdbqxo+4S5M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-_EWqL09gMYqSi0knuo-H_Q-1; Wed, 06 May 2020 04:08:32 -0400
X-MC-Unique: _EWqL09gMYqSi0knuo-H_Q-1
Received: by mail-wm1-f70.google.com with SMTP id s12so795621wmj.6
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 01:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CBWxp/RqrAZHRhIdtBhb3xri0XLzwh+Ch7QU+ftNF34=;
        b=Ucj5ZmaX1tufTy1zq9btN7jDI1ZI8dMSqNDHHnPHv/ngWvamx5WsJ9abvQAyKhsIJb
         mN7+rtZkE6rYTsbkAvTQ5AVJZoJXxOpQs5HMafMZEpxgr54D9jmhk8hP/5Dhcxvby0kC
         mHpkHfE7rHvYwMLRO2aIueTXETO8LlAeusexK+3gcd2HDgNoOHvhIwTXrObay3MupWD9
         GTlcv7+zDnLxlH80Se7NLrLdbGX7RMWJBquZXt3dGBdUte6v44Z2xwj7afSWicAaJ/0z
         pedMrh5mVkvTlA13BFY0kzfVdvmgnMLAVzmFkipl3ztV3h/1L80L5z/Hw4xnPfjImcTA
         fYvg==
X-Gm-Message-State: AGi0PubVmwuDt/bVRTzTOn0j58VsM/a5LIMcZaDKZTZ94etgV3IqdZU0
        KikDrUz2rAeKc7jO38zfgNHpMsxZ82XRUovvyTCEzHe6uWoDxTLH5jP/SHAy/IGVB37t1hTw8Ke
        Xtc3gqWmPNumQ
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr8713634wrv.73.1588752511065;
        Wed, 06 May 2020 01:08:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypKoYFzRFdcs5OUqDOntDuXyJrKD5k/C6ihqMqcjU/DctdS4/KReL94LfbKFGzcZw7Aen1K6xw==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr8713617wrv.73.1588752510881;
        Wed, 06 May 2020 01:08:30 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id g25sm1724902wmh.24.2020.05.06.01.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 01:08:30 -0700 (PDT)
Date:   Wed, 6 May 2020 04:08:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
Subject: performance bug in virtio net xdp
Message-ID: <20200506035704-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

So for mergeable bufs, we use ewma machinery to guess the correct buffer
size. If we don't guess correctly, XDP has to do aggressive copies.

Problem is, xdp paths do not update the ewma at all, except
sometimes with XDP_PASS. So whatever we happen to have
before we attach XDP, will mostly stay around.

The fix is probably to update ewma unconditionally.

-- 
MST

