Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB202DE1BC
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389096AbgLRLFi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Dec 2020 06:05:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733110AbgLRLFi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 18 Dec 2020 06:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608289452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ekDfiKBvfpxU0bWX1IyxVyj0gbpvMm6uRrEf41nOeAs=;
        b=NLDR/uJegLEvNNqIzjCMHVLg9Dsj2aJkjYWCL6WULftOXSo/zEnnAL85wsejsoZ07ZmecZ
        LJRZahBaTKnIlHR9CbbmMJuzN8l/reQF7qRpBDwIfhecnKfJZt4r7ucwdJ/k+EYa2HbRDg
        0SKwGyha/0WETKZDPFroW+nnClhBfO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-DMQM8guNNC2sEBiTNX1EUw-1; Fri, 18 Dec 2020 06:04:10 -0500
X-MC-Unique: DMQM8guNNC2sEBiTNX1EUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DA46800D53;
        Fri, 18 Dec 2020 11:04:09 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-120.ams2.redhat.com [10.36.112.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02D9F72163;
        Fri, 18 Dec 2020 11:04:07 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Meng Zhuo <mengzhuo1203@gmail.com>, linux-api@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: Please remove all bit fields in bpf uapi
References: <CACt3ES2LCfNDq-nskrySJjWD5EO9WCAst_+kJT7UbhYOmD+45g@mail.gmail.com>
        <X9xu2q8QFCCf70r7@kroah.com>
        <CACt3ES3NTRZF4jbCjgHybGHofNypQ3EPnYvuJi-eZZXJtonQUg@mail.gmail.com>
        <X9yE+hJpT73PdKjG@kroah.com>
Date:   Fri, 18 Dec 2020 12:04:06 +0100
In-Reply-To: <X9yE+hJpT73PdKjG@kroah.com> (Greg KH's message of "Fri, 18 Dec
        2020 11:31:22 +0100")
Message-ID: <87im8z1il5.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* Greg KH:

> On Fri, Dec 18, 2020 at 05:09:58PM +0800, Meng Zhuo wrote:
>> Hi, Greg
>> 
>> Thank you for your reply
>> It's fine to do compile bit fields "by hand".
>
> Surely Go has something like "if (field & 0x01)", right?  That's all you
> need for a bitfield.
>
> Look at the most common syscall, open(2)?  It uses bitfields, why
> can't Go handle that?

Flag arguments are very different from bit-fields in struct types.

Structs with bit-fields are not part of the highly portable C subset.
Even C compilers differ in their interpretation.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

