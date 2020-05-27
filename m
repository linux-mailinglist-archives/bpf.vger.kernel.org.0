Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81E1E3A28
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 09:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgE0HQj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 03:16:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28464 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728611AbgE0HQj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 May 2020 03:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590563798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u7x0jTKoQmKpSGjtoUTtN61JtxPAQOe3q2OSG4tdCyk=;
        b=PqtKXlC+vUBKO9MqcTpQRV2OgF1PvSCEnm2JtQ9b1cfEl6twv1DSeUmq62KWGv3FwEN+QG
        igCWITB1M9mAQpOHhoe/MYcWMONfH+i3j9ky45blwnMDE0Wuhj01HA2ILXqhk/KdJlMi+2
        mN6KO+BN56Q6BNIAYStl7X09lkg+tXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-RNe6AOL6OFuQk3duszCb6w-1; Wed, 27 May 2020 03:16:34 -0400
X-MC-Unique: RNe6AOL6OFuQk3duszCb6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 661121855A01;
        Wed, 27 May 2020 07:16:33 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-49.ams2.redhat.com [10.36.114.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ECA01A7DB;
        Wed, 27 May 2020 07:16:31 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     jbenc@redhat.com, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org
Subject: [RESEND PATCH 0/3] selftests: lib.mk improvements
Date:   Wed, 27 May 2020 10:16:29 +0300
Message-Id: <20200527071629.63364-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix 
make[1]: execvp: /bin/sh: Argument list too long

encountered with some shells and a couple of more potential problems
in that part of code.

Yauheni Kaliuta (3):
  selftests: do not use .ONESHELL
  selftests: fix condition in run_tests
  selftests: simplify run_tests

 tools/testing/selftests/lib.mk | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

-- 
2.26.2

