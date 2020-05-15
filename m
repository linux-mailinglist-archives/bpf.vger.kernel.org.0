Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA31D4DE3
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 14:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOMkb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 08:40:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31972 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726097AbgEOMkb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 08:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589546430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRSV/QZvGS2cVLHIigENsfB9/KD6iEh2gqdtODung4o=;
        b=FbqGySOosdgtcbGuMSzwIsX3BMxpG3LLsVZIoqulXAr3njr9MRj2KnZZib92wYebajMrng
        6u3mbQ9VyfIyxhGvAa9OLmJHmb9z3xnIZJ06b7OkafTpU4dYWg+NV96z306rRs/OjBbRIT
        eX6znUdcIbOB/x4Ptb7YHmK1zFaeYs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-LgzIdASmNb2iYTHrLNT7Ew-1; Fri, 15 May 2020 08:40:29 -0400
X-MC-Unique: LgzIdASmNb2iYTHrLNT7Ew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2615A64AD9;
        Fri, 15 May 2020 12:40:28 +0000 (UTC)
Received: from localhost (unknown [10.40.194.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1583A5C241;
        Fri, 15 May 2020 12:40:26 +0000 (UTC)
Date:   Fri, 15 May 2020 14:40:25 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 2/3] selftests: fix condition in run_tests
Message-ID: <20200515144025.20495d63@redhat.com>
In-Reply-To: <20200515120026.113278-3-yauheni.kaliuta@redhat.com>
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
        <20200515120026.113278-3-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 15 May 2020 15:00:25 +0300, Yauheni Kaliuta wrote:
> The check if there are any files to install in case of no files
> compares "X  " with "X" so never false.
> 
> Remove extra spaces. It may make sense to use make's $(if) function
> here.
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

Acked-by: Jiri Benc <jbenc@redhat.com>

