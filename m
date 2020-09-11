Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44678265967
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgIKGeB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 02:34:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22161 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725468AbgIKGeB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 02:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599806040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HwIuVWCp6IGPsQDBIiSkMo+i0w+JFDcylc+ewi7PKJI=;
        b=ZT3fEyxyhHwvjF1GWhtVbqqoktOpgNylPJER1O3B8HOJMGZ7cw1m/YZCFSYKfoAAGIx8GT
        vm/agUqG5Vlo3Dgc23U9R8yxBp3OT8CDiwuSrbCQp91BwIeCdIO+CSOZVEfFxuUpvdQbqb
        62scJXgZ7Sq6BEfksUdCfObb3P1ltgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-JIbiQy6fPteN9ZKBb_CGSg-1; Fri, 11 Sep 2020 02:33:56 -0400
X-MC-Unique: JIbiQy6fPteN9ZKBb_CGSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC8FE1084CA4;
        Fri, 11 Sep 2020 06:33:54 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-109.ams2.redhat.com [10.36.112.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B93625D9E8;
        Fri, 11 Sep 2020 06:33:52 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 5/5] bpf: Do not include the original insn
 in zext patchlet
References: <20200909233439.3100292-1-iii@linux.ibm.com>
        <20200909233439.3100292-6-iii@linux.ibm.com>
        <CAADnVQ+2RPKcftZw8d+B1UwB35cpBhpF5u3OocNh90D9pETPwg@mail.gmail.com>
Date:   Fri, 11 Sep 2020 09:33:50 +0300
In-Reply-To: <CAADnVQ+2RPKcftZw8d+B1UwB35cpBhpF5u3OocNh90D9pETPwg@mail.gmail.com>
        (Alexei Starovoitov's message of "Thu, 10 Sep 2020 17:25:43 -0700")
Message-ID: <xunyk0x0styp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Alexei!

>>>>> On Thu, 10 Sep 2020 17:25:43 -0700, Alexei Starovoitov  wrote:

 > On Wed, Sep 9, 2020 at 4:37 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
 >> 
 >> If the original insn is a jump, then it is not subjected to branch
 >> adjustment, which is incorrect. As discovered by Yauheni in

 > I think the problem is elsewhere.
 > Something is wrong with zext logic.
 > the branch insn should not have been marked as zext_dst.
 > and in the line:
 > zext_patch[0] = insn;
 > this 'insn' should never be a branch.
 > See insn_no_def().

Yes, it may be the case, as I mentioned in my analysis, but the
patching itself looks much more clear with Ilya's changes.

-- 
WBR,
Yauheni Kaliuta

