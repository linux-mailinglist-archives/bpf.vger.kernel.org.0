Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B618327A4A
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 10:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhCAJAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 04:00:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233783AbhCAI6W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Mar 2021 03:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614589014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=aLB13ED3pJuh7ZoJ1xGZR2HBJ1yEuvpghvAKuV6TddA=;
        b=GkwLdInipN1T+cHwYATTdWXoCVBD4YglYFOnUd45rU6Dhzr2gd+Dhs+/cvWZtC5OZ/Zuj2
        MO89Kw1yNUEpcFTuiFbLP1S6Eaev5fyFLOV/8G+bw4slFgZMwHmmP2Q300/ZrtVL8PFM3R
        Jf9vctnYtT4Em4TxPkeQenx//eKE3ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-n6ZkF3WkMCGdnFha19iBqA-1; Mon, 01 Mar 2021 03:56:52 -0500
X-MC-Unique: n6ZkF3WkMCGdnFha19iBqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8509107ACE3
        for <bpf@vger.kernel.org>; Mon,  1 Mar 2021 08:56:51 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-135.ams2.redhat.com [10.36.114.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3838362665
        for <bpf@vger.kernel.org>; Mon,  1 Mar 2021 08:56:50 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Subject: bpf selftests and page size
Date:   Mon, 01 Mar 2021 10:56:48 +0200
Message-ID: <xunyim6b5k1b.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

Bunch of bpf selftests actually depends of page size and has it
hardcoded to 4K. That causes failures if page shift is configured
to values other than 12. It looks as a known issue since for the
userspace parts sysconf(_SC_PAGE_SIZE) is used, but what would be
the correct way to export it to bpf programs?

-- 
WBR,
Yauheni Kaliuta

