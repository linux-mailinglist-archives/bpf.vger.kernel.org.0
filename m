Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25D21C92BA
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEGO5D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:57:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726776AbgEGO5C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588863421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=//kkxKzi+0qHLRhrSfuR3mbaANtAJZOIfCH1+qVX7p0=;
        b=BUhnmsPHEcAmWpZgFN3oLNbCAm8TxbL35P1AjK3+wzUzEsujN0nCWsIWnT111GjHz3HG38
        wwrW5H8DBqxnsL4OO7oTH7td0THAFeD5TppBXbuoa9f8fZd2eWCuDC2FKCsMYBzkiJYXbF
        LjDx4yBZ/7tcsYIXl4n73u0ULEperrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-f8RzcqHZOOKiJolKa5sVPA-1; Thu, 07 May 2020 10:56:58 -0400
X-MC-Unique: f8RzcqHZOOKiJolKa5sVPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02FE7801504;
        Thu,  7 May 2020 14:56:57 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-223.ams2.redhat.com [10.36.112.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AE826295A;
        Thu,  7 May 2020 14:56:55 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 0/2] libbpf: fix powerpc check_kabi rule
Date:   Thu,  7 May 2020 17:56:50 +0300
Message-Id: <20200507145652.190823-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Yauheni Kaliuta (2):
  Revert "libbpf: Fix readelf output parsing on powerpc with recent
    binutils"
  libbpf: use .so dynamic symbols for abi check

 tools/lib/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.26.2

