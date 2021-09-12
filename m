Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9EF407B45
	for <lists+bpf@lfdr.de>; Sun, 12 Sep 2021 04:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhILCC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Sep 2021 22:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231743AbhILCC7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 11 Sep 2021 22:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631412105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EyikGfhK6ZBuK8sEBsdOp0Sy5GjF53gp/LzsVSTkDzg=;
        b=VMYJlNi4efuy/3BMh2V32t2FQoPltAvE4TJUtQDi2QvgtqFoGwnSY4y+zBUdtG2LRxDuMQ
        GXiFcKY6DvYhrl9lc4UqO0Z99ziKziqivGDxoC0KtyqZ7Z+EEs4jFrnQl0JedpP32mnHKk
        NfGtMlAhK5GSliQjrPKGv4lQAm3f3ZI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-cZncf9osNGGwyyHJs_HuHQ-1; Sat, 11 Sep 2021 22:01:43 -0400
X-MC-Unique: cZncf9osNGGwyyHJs_HuHQ-1
Received: by mail-pg1-f200.google.com with SMTP id g15-20020a63564f000000b00261998c1b70so4824845pgm.5
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 19:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=EyikGfhK6ZBuK8sEBsdOp0Sy5GjF53gp/LzsVSTkDzg=;
        b=VkbOz1N9rv40HTXjnhVHN6mjHDa6nbZDfUrYzWtoBVj6S1O+kcI1mN1q4pNdDlm8OT
         xrQOH9KwKoNZQ3ulN/zwFo4jiTg8xbdV+4OzbvurnSdh3ZMktIWZMmx/8NYQAWGqQtwj
         iNmlNoywnotOgyhQr2QuvY+4+7CCASguDtj3r/dw2oYGuPGCw5qqgZlw89LUaMlIAjIR
         j9XmwwvIcLnlraY9gY+zOd/xBu9fNAzEuChUB0EKVXnhqAhl/fLT792QR3+l/0cL/vmK
         bPvlbFzAWXOhBCZL0N7eY2KVJI/CONfM/rsxk2QK+uqobChn2OROjaP5GDu6TAkDlKUq
         Oe8A==
X-Gm-Message-State: AOAM531OWcE8+hAgeAmNjbxm/LxwN6JG2a3mZVhLUCYyeu6Sce/qYT8j
        NqjwXyTaWTvpLk4k6YG68Uxc0JHTxuBwVJeHAiez0gyftOXWJnQ6vc4wHDX1AVjSSIc+eUik62+
        bFqIAl0cozkWc
X-Received: by 2002:a17:90a:9291:: with SMTP id n17mr5473649pjo.243.1631412102796;
        Sat, 11 Sep 2021 19:01:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAVlePM7TLoSO1fdiDoUYzdCCOCSTnPzs2ThmCm3HRYLIiLQ9HcJZ5MM1XKYXTmCyGjFMryg==
X-Received: by 2002:a17:90a:9291:: with SMTP id n17mr5473608pjo.243.1631412102531;
        Sat, 11 Sep 2021 19:01:42 -0700 (PDT)
Received: from smtpclient.apple ([2600:380:4738:b4a5:7850:2b24:ea76:1118])
        by smtp.gmail.com with ESMTPSA id h16sm2869606pfn.215.2021.09.11.19.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 19:01:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Josh Poimboeuf <jpoimboe@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] x86: change default to spec_store_bypass_disable=prctl spectre_v2_user=prctl
Date:   Sat, 11 Sep 2021 19:01:40 -0700
Message-Id: <AAA2EF2C-293D-4D5B-BFA6-FF655105CD84@redhat.com>
References: <202109111411.C3D58A18EC@keescook>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
In-Reply-To: <202109111411.C3D58A18EC@keescook>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: iPhone Mail (18G82)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 11, 2021, at 2:13 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
> =EF=BB=BFOn Wed, Nov 04, 2020 at 06:50:54PM -0500, Andrea Arcangeli wrote:=

>> Switch the kernel default of SSBD and STIBP to the ones with
>> CONFIG_SECCOMP=3Dn (i.e. spec_store_bypass_disable=3Dprctl
>> spectre_v2_user=3Dprctl) even if CONFIG_SECCOMP=3Dy.
>=20
> Hello x86 maintainers!
>=20
> I'd really like to get this landed, so I'll take this via the
> seccomp-tree unless someone else speaks up. This keeps falling off
> the edge of my TODO list. :)

Thanks!  You can add my

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

