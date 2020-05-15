Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760CB1D4DE2
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 14:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgEOMkX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 08:40:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48812 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726097AbgEOMkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 May 2020 08:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589546422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjG2mRh81/sRZtJsBFZU2NbuLGDdDfOtgMcrRFUafqs=;
        b=CGQpKc+xrT8UMrJOcZPSzDH+luh04UHLfvQmhkHnNh62lD7IDBkb1E0MXZsSWQOPv8LPQd
        CTkLg8JZXtj5fsA01iFlh8O7HK7Mug5Xal7WhWwLgTke9wAyencgDauSGgrXCsD/gjjQOj
        qvup0UNll8D1FNxjOlnnrXOrGoFOmfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-zh3bkgcMMmWn2tHbOsDEzw-1; Fri, 15 May 2020 08:40:19 -0400
X-MC-Unique: zh3bkgcMMmWn2tHbOsDEzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D61B61268;
        Fri, 15 May 2020 12:40:19 +0000 (UTC)
Received: from localhost (unknown [10.40.194.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EAF775C241;
        Fri, 15 May 2020 12:40:14 +0000 (UTC)
Date:   Fri, 15 May 2020 14:40:12 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 1/3] selftests: do not use .ONESHELL
Message-ID: <20200515144012.68449fee@redhat.com>
In-Reply-To: <20200515120026.113278-2-yauheni.kaliuta@redhat.com>
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
        <20200515120026.113278-2-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 15 May 2020 15:00:24 +0300, Yauheni Kaliuta wrote:
> Using one shell for the whole recipe with long lists can cause
> 
> make[1]: execvp: /bin/sh: Argument list too long
> 
> with some shells. Triggered by commit 309b81f0fdc4 ("selftests/bpf:
> Install generated test progs")
> 
> It requires to change the rule which rely on the one shell
> behaviour (run_tests).
> 
> Simplify also INSTALL_SINGLE_RULE, remove extra echo, required to
> workaround .ONESHELL.
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Cc: Jiri Benc <jbenc@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>

Acked-by: Jiri Benc <jbenc@redhat.com>

