Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC01D277B
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 08:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgENGWy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 02:22:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54921 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725818AbgENGWx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 May 2020 02:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589437372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORRF1oRqou1UVf5I8jcn96BG1p+KSStsuMY82XoCekE=;
        b=h7uwb69k8a32rI8pOTgsRel0TomlllqvydjnfM4Rzi+0ICQ1RcULQFBW1O6FBrEOkxAt8X
        c7w3rewUGoOg05h9P6xZG+A+1wSj723gRbwjdllUikNdOYQE94coA3VBeaneKp3phgR1S7
        0mS/aIEw5V9XoxTJ9nCXXcEN6D9LFk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-msEyzzc3NyiFxbY9LNNAvQ-1; Thu, 14 May 2020 02:22:50 -0400
X-MC-Unique: msEyzzc3NyiFxbY9LNNAvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5938619200C1;
        Thu, 14 May 2020 06:22:49 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-113-25.ams2.redhat.com [10.36.113.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C52076E50B;
        Thu, 14 May 2020 06:22:47 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH] selftests/bpf: install generated test progs
References: <20200513021722.7787-1-yauheni.kaliuta@redhat.com>
        <396aa431-82fc-b93e-7c69-3d215d1d9939@iogearbox.net>
Date:   Thu, 14 May 2020 09:22:45 +0300
In-Reply-To: <396aa431-82fc-b93e-7c69-3d215d1d9939@iogearbox.net> (Daniel
        Borkmann's message of "Wed, 13 May 2020 16:55:22 +0200")
Message-ID: <xunyeernox1m.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Daniel!

>>>>> On Wed, 13 May 2020 16:55:22 +0200, Daniel Borkmann  wrote:

 > On 5/13/20 4:17 AM, Yauheni Kaliuta wrote:
 >> Before commit 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
 >> test_maps w/ general rule") selftests/bpf used generic install
 >> target from selftests/lib.mk to install generated bpf test progs by
 >> mentioning them in TEST_GEN_FILES variable.
 >> 
 >> Take that functionality back.
 >> 
 >> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
 >> test_maps w/ general rule")
 >> 
 >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

 > Applied, thanks!

Thanks! Should I do anything about
https://lore.kernel.org/bpf/20200507145652.190823-3-yauheni.kaliuta@redhat.com/T/#mbeddec628675f06f176528b67d570aee0539ebbf yet?


-- 
WBR,
Yauheni Kaliuta

