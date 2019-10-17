Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590CCDA938
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393782AbfJQJue (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 05:50:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32911 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389021AbfJQJue (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 05:50:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so1874514ljd.0
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 02:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=VOpKmwMwV+SX3a2cTSW8olQRM71I/wGBB7bz1Yg3eQM=;
        b=Iae6zscmX3HbQBgmamadRKQU441b4aYUAVax/2HNJZ7/nJ0MA8q13JUrR57DLlc2jM
         xMbfG23OTHdOItUjNfwBu5XxFUwp7htQWqhEgcTowgsdKeMqMAjmxirJIdhT84/rcmzF
         Oqa2uSj22NU/2SSkXCk9RKjoFxwDnFvxsSaGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=VOpKmwMwV+SX3a2cTSW8olQRM71I/wGBB7bz1Yg3eQM=;
        b=A0Cn16j7mUqfXY6b5H2fMiWdjWuYDhPeouVG64pkeliRKjcAXAN42aLudbuwNe7SHO
         vN/JbPS7rxYQmaQ4DClQvoyeTbxiOKkZHIeyp6RJzpCKtlxw9rsrLmr25hrAlC24DXpJ
         RWf6GOymSd0QTs4GspzN24qlCNqnRcI6X2Wk+317JBxyyyAF7xe7SAAN6yEzVub4poP1
         vQYMCwWJGKo38s7WLaZO4yUvZ2GDhRPuCMzVCMO/4MJtvdTNJsa5ZBRA6berUrCxkkNB
         9oXRgieLWTjo0EYR4GtOl7xg06vpeEDse9Dssl2PJ1oBDKeumU9x4Fbbc2glqHWOsMR5
         /lWg==
X-Gm-Message-State: APjAAAXNJmKd7JL2heQH9j0KG4slKT8tDce4wThmIFrDMU/BXLqC4O/m
        RV4iyxHRpFVfuAeHykpgUB0I3A==
X-Google-Smtp-Source: APXvYqxEt7OszEvTT4lKuGUk0NtFk4bsU+dbJP6aVrVI3o80DFziyLa+uhtZwI/TMs9kiTQRq3WR+A==
X-Received: by 2002:a2e:b010:: with SMTP id y16mr1923003ljk.147.1571305831670;
        Thu, 17 Oct 2019 02:50:31 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id f6sm777125lfl.78.2019.10.17.02.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 02:50:31 -0700 (PDT)
References: <20191016085811.11700-1-jakub@cloudflare.com> <CAEf4BzYUoGx9G6-8EYWReTamNGVmrOcWHEaqemRuv8+np1x17Q@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next] scripts/bpf: Emit an #error directive known types list needs updating
In-reply-to: <CAEf4BzYUoGx9G6-8EYWReTamNGVmrOcWHEaqemRuv8+np1x17Q@mail.gmail.com>
Date:   Thu, 17 Oct 2019 11:50:30 +0200
Message-ID: <875zknog49.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 16, 2019 at 10:29 PM CEST, Andrii Nakryiko wrote:
> On Wed, Oct 16, 2019 at 6:21 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> Make the compiler report a clear error when bpf_helpers_doc.py needs
>> updating rather than rely on the fact that Clang fails to compile
>> English:
>>
>> ../../../lib/bpf/bpf_helper_defs.h:2707:1: error: unknown type name 'Unrecognized'
>> Unrecognized type 'struct bpf_inet_lookup', please add it to known types!
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  scripts/bpf_helpers_doc.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
>> index 7df9ce598ff9..08300bc024da 100755
>> --- a/scripts/bpf_helpers_doc.py
>> +++ b/scripts/bpf_helpers_doc.py
>> @@ -489,7 +489,7 @@ class PrinterHelpers(Printer):
>>          if t in self.mapped_types:
>>              return self.mapped_types[t]
>>          print("")
>> -        print("Unrecognized type '%s', please add it to known types!" % t)
>> +        print("#error \"Unrecognized type '%s', please add it to known types!\"" % t)
>
> My bad, this was intended to be printed to stderr, not to stdout
> output. Can you please do a follow up patch turning this into eprint
> instead?
>
> This shouldn't be reported by Clang, rather by tool. And we should
> ensure in libbpf's Makefile that bpf_helper_defs.h is deleted on
> error. I'll do it a bit later, unless you'll beat me to it.

This sounds sensible. I could have guessed it. Here's the fix:

https://lore.kernel.org/bpf/20191017094416.7688-1-jakub@cloudflare.com/T/#u

-Jakub
