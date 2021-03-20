Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73178342F23
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 20:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCTTHd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Mar 2021 15:07:33 -0400
Received: from wforward1-smtp.messagingengine.com ([64.147.123.30]:47849 "EHLO
        wforward1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229920AbhCTTHX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 20 Mar 2021 15:07:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailforward.west.internal (Postfix) with ESMTP id 78AB910D1;
        Sat, 20 Mar 2021 15:07:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 20 Mar 2021 15:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=65SJSfwlPLdBSTATDTczUb8ZLLUVsy/Z/UCcypFoR
        bg=; b=cUimlmF5LE/H3xeEfqrrZbL1u3apZqABw8hcMp+qc6+SHmjz+j/8/ijRW
        haYJowW3km7JswAXmG/PZA464qrQ3FBMPA3QNPj+QiZxvkzj2ZLhhidFSaIiP+nx
        YaNDZ3Is1eG5km0FlMkNh12RFPty/W4lZSHaIkk4CWce5RsqUIF2YI8X8QAv72xq
        OlZY2LS+bc6QDcVH5ktgDTc3RwpWk7Qty7y74oVCg7cWEKeZRy7o477G4ikobDsQ
        S3uMnKu2nPrpPidl5AAAKsbyjgEUO/bM28s+cuDEK52PyBGzDDrcW5ED7BLsCWMI
        Uy+dJWkFgJgik0I4RTyYYpYANrUTA==
X-ME-Sender: <xms:6UdWYNLPzpkIfPT37RXI5tRUrZbpVwR05Wu1tS6HTuzyW1hRRJassg>
    <xme:6UdWYJJEU0V0gtDVd28A89Yh6X9UMQkroIAhmnxr1r59RfhGzFYnefQ6nn3ZvVgnH
    vCH1Oye_-eIBtG0NH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegtddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjfffgkfhfvffosehtjehmtdhhtddvnecuhfhrohhmpeftrghf
    rggvlhcuffgrvhhiugcuvfhinhhotghouceorhgrfhgrvghlughtihhnohgtohesuhgsuh
    hnthhurdgtohhmqeenucggtffrrghtthgvrhhnpeeugfffudffkeeggeeffeegkefgkefg
    udduudejleekfeehvdeikeetheejjeeijeenucfkphepudefkedrvddtgedrvdeirdduie
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghf
    rggvlhguthhinhhotghosehusghunhhtuhdrtghomh
X-ME-Proxy: <xmx:6UdWYFu2Bx5xHyO3AtbuWC5b1iRVIOUfudTGcDTtlURK1zAUJhZV8g>
    <xmx:6UdWYObS5QFu2JSx98Ma_8v03xw9ZMnIBYC3Rt89cE5HFwiEDMEl6w>
    <xmx:6UdWYEY0oWZE-DE9i5DR4FDJZzjFhtu82S5D_J8JYa0LMl0FN8e0Ag>
    <xmx:6kdWYK23MK6a5p0r37dvkyH5GTiK5axv-u-QW5oFwKlkZC_TCIr5RMH3vl4>
Received: from [192.168.100.154] (unknown [138.204.26.16])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF1F01080054;
        Sat, 20 Mar 2021 15:07:20 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] libbpf: add bpf object kern_version attribute setter
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <CAEf4BzZ-gwnMGrKQJk1eeF_GmM703h13oXe1NXJhrXpF1Vw-Mg@mail.gmail.com>
Date:   Sat, 20 Mar 2021 16:07:16 -0300
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
X-Mao-Original-Outgoing-Id: 637960036.139249-ecd43e0f288532b24ec5079de235d418
Content-Transfer-Encoding: 7bit
Message-Id: <757481A6-503F-4637-A017-0834E68FFCCC@ubuntu.com>
References: <20210320041623.2241647-1-rafaeldtinoco@ubuntu.com>
 <CAEf4Bzah-xFhO-hDzsZZoynsR_BuihAHVQ4jUMPYqyPstdJ9_Q@mail.gmail.com>
 <CAEf4BzZ-gwnMGrKQJk1eeF_GmM703h13oXe1NXJhrXpF1Vw-Mg@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>>> +int bpf_object__set_kversion(struct bpf_object *obj, char *kern_version)
>>> +{
>>> +       __u32 major, minor, patch;
>>> +
>>> +       if (!kern_version) {
>>> +               obj->kern_version = 0;
>>> +               return 0;
>>> +       }
>>> +       if (sscanf(kern_version, "%u.%u.%u", &major, &minor, &patch) !=  
>>> 3)
>>
>> given SEC("version") expects `int` and bpf_object__kversion() returns
>> int, I think it's appropriate for bpf_object__set_kversion() to accept
>> just opaque int as well. Please also check that obj is not loaded and
>> return error if it is. Thanks!
>
> Oh, and please use [PATCH bpf-next] subject prefix to specify that
> this is destined to the bpf-next tree. You'll also add v2 in between
> PATCH and bpf-next for the next version, of course.

will do, and sorry for the initial burden, getting used to libbpf devel.
