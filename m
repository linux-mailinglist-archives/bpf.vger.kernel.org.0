Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47CF3BE8E9
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhGGNln (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhGGNln (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 09:41:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661AC061574
        for <bpf@vger.kernel.org>; Wed,  7 Jul 2021 06:39:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a6so3514509ioe.0
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:mime-version:message-id:in-reply-to:references:date:from
         :to:cc:subject;
        bh=cYEtjynVeNKy8n7/FJu26STUQHmlWuNHGzV9+GgWKbU=;
        b=TM242lrWyhOHv/qypHDH8tsCc0LwTeLQyBAcoMJb8ba1W5mAKi2QTPL1sfJuwLASa5
         4/7gbz5Vh46tapLL9exp6sqaHJQ9lEN+nCCnOS7gYMnwfA337Bd0JbNsJWSbAZKUdrxX
         GscJlnVO29nQKB43l2EGAY4C5tOTZxJFU/UqVrd+1Z/IXoQAKxMmzTWudy9Inji6p9bE
         024PYTFqe05AT4mGTafjaWOiF97G7IAl60pSaxDj0gyztXKBTkKLM6mCqIQmI9bKZINY
         MxW3LxqPtbKr7+FqxaH1AYUD8hiW6tcUaylDNJUxG0+6WDQyQZ0wWmSaiRUK89Ro83Bu
         UPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:mime-version:message-id:in-reply-to
         :references:date:from:to:cc:subject;
        bh=cYEtjynVeNKy8n7/FJu26STUQHmlWuNHGzV9+GgWKbU=;
        b=jGKpWGDglSo5/vSS5LDrfL3dQAk0NBBk4AuWJg1ULnbbBMwb8rflqv0MHM01m3Vbev
         KtkI74k8bVkl6LOOUyDRfsTw1dzMy7RFC4x0pveus6QeJ90YOzrtS8wWAsA/EqHzcMAI
         FvGB4Uh7RbU9CPMjLLrJvYhB1d5NhFs8TW2244ZryurNZhJw9O2CYXCYfjL6T6gsF5WI
         34/V3AYP59dEDZbovh+7tZ9ko0PZhcx61OsAyoQKdvXbnhMvf2Je4GVg7X9yaIUvh9il
         dPhsWEHgWppTk1hvIwGKlzeSRzMJW0KUApsMIAtGWszgGu6ezv4B5JNbapblDQ2tgG5o
         +taQ==
X-Gm-Message-State: AOAM532HKv4s7xVz9ZaRwJvA49GcQPHznJikiX+ead7dCy94nFbclY/v
        q9PMSNmrwniOOVjUTdNefg==
X-Google-Smtp-Source: ABdhPJxZuLIKnkNXFqY6gPY2+1KhuJOa5ennelckg8G9u/W6qtj9hO7hhTW8sAVJVdcsL6jk40amGQ==
X-Received: by 2002:a05:6602:1219:: with SMTP id y25mr4759050iot.23.1625665142699;
        Wed, 07 Jul 2021 06:39:02 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q7sm2535451ioi.34.2021.07.07.06.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:39:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8923B27C005B;
        Wed,  7 Jul 2021 09:39:01 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute3.internal (MEProxy); Wed, 07 Jul 2021 09:39:01 -0400
X-ME-Sender: <xms:da7lYE9e6-sH9VyprmpODphc_SeBDejOPfcBvlR7dUqAtRwhav8u1Q>
    <xme:da7lYMs9vKTAtwGLVRhcgUBZGtUCWjA1MULa4aJSUzjJML_F30YS2u_9H20EzX7KF
    SYLgd3N1lYJt4H1Wnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddvgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
    dtreerjeenucfhrhhomhepfdftrghfrggvlhcuffgrvhhiugcuvfhinhhotghofdcuoehr
    rghfrggvlhguthhinhhotghosehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpe
    eltdetleefkeejledvleeijeefhfekueffieetuddtleeufeekhfevtdffieegueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlh
    guthhinhhotghoodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduuddvheei
    heeltdegqddvheehkeejleefiedqrhgrfhgrvghlughtihhnohgtoheppehgmhgrihhlrd
    gtohhmseduvdefmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:da7lYKAJLzyTNTXhj0NcKKcbLcWRyHxch5UyOrYYWq4mUesnMWwggA>
    <xmx:da7lYEdFEMf2npMnGRdcmajB6mq7_rZBOklzt0GVoIqFXPWz24RMRw>
    <xmx:da7lYJMN4wsCcUzlKkfEn5ttZ5ZYLeI85RmfEW8A73pODpm2UNyGbQ>
    <xmx:da7lYAY_wJkMSWkxAmXxMp5PhmGysCB7eqlgEkHDgDHaYS-kveAMLw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4E5564E00C3; Wed,  7 Jul 2021 09:39:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-531-g1160beca77-fm-20210705.001-g1160beca
Mime-Version: 1.0
Message-Id: <d63ac37d-585a-46a7-b262-76e827a382c5@www.fastmail.com>
In-Reply-To: <20210625044459.1249282-1-rafaeldtinoco@gmail.com>
References: <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
 <20210625044459.1249282-1-rafaeldtinoco@gmail.com>
Date:   Wed, 07 Jul 2021 10:38:40 -0300
From:   "Rafael David Tinoco" <rafaeldtinoco@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii.nakryiko@gmail.com
Subject: =?UTF-8?Q?Re:_[PATCH_bpf-next_v3]_libbpf:_introduce_legacy_kprobe_events?=
 =?UTF-8?Q?_support?=
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 25, 2021, at 01:44, Rafael David Tinoco wrote:
> Allow kprobe tracepoint events creation through legacy interface, as the
> kprobe dynamic PMUs support, used by default, was only created in v4.17.
> 
> This enables CO.RE support for older kernels.
> 
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>

ping
