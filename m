Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F481D9A5E
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgESOuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 10:50:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30696 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726880AbgESOuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 10:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589899806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w2XUngnLZtW7XIr4Ix0OUD7C12BtNVeTVxdhwNMrRCI=;
        b=C836Al7w+NoWTL6O18vCmqTy5Q2W7QAw7voCx0OibvmZ1/MtNrpx4x8Z91NE6UXFScagqM
        KV/kbWcXZT6qzPWnjz+GkheCnGI6apmE7JDpkVPpRdx80QciFeyRCD75aAQcZ7Ukdc/p/a
        72ljAU9GC/ut95HSQC1LR3X6g4QeVEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-wK6FVXiiNh6MxiqTOsMDmw-1; Tue, 19 May 2020 10:50:02 -0400
X-MC-Unique: wK6FVXiiNh6MxiqTOsMDmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D42E918CA27D;
        Tue, 19 May 2020 14:50:01 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-168.ams2.redhat.com [10.36.112.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA3C53A1;
        Tue, 19 May 2020 14:49:59 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     shuah <shuah@kernel.org>
Cc:     bpf@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 0/3] selftests: lib.mk improvements
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
        <689fe06a-c781-e6ed-0544-8023c86fc21a@kernel.org>
Date:   Tue, 19 May 2020 17:49:57 +0300
In-Reply-To: <689fe06a-c781-e6ed-0544-8023c86fc21a@kernel.org>
        (shuah@kernel.org's message of "Tue, 19 May 2020 07:59:16 -0600")
Message-ID: <xunyblmknfmy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, shuah!

>>>>> On Tue, 19 May 2020 07:59:16 -0600, shuah   wrote:

 > On 5/15/20 6:00 AM, Yauheni Kaliuta wrote:
 >> 
 >> Yauheni Kaliuta (3):
 >> selftests: do not use .ONESHELL
 >> selftests: fix condition in run_tests
 >> selftests: simplify run_tests
 >> 
 >> tools/testing/selftests/lib.mk | 19 ++++++-------------
 >> 1 file changed, 6 insertions(+), 13 deletions(-)
 >> 

 > Quick note that, I will pull these in for 5.8-rc1.

Thanks!

-- 
WBR,
Yauheni Kaliuta

