Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5373664D242
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 23:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLNWUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 17:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNWUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 17:20:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157AF41992
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 14:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671056370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+o1xEsC0omMshrEGR2o39o0qaRI2mMB3dbNaYbeBWY=;
        b=MSQmBUT70u+P6dAhcKbSydNcfYVug9Nvf3ODek5E3R4QLojWoMAcSi9HKu1719JySNiQbU
        OAzNmSv+8L0vPT9KQWQRiI3f0E0z1WJAwwtGGZS+7SFOYWAUokvY+MkyRw4IbreQcatc1Q
        piyp7rvJRHX2vYd6MLXxQFtEMLBOe+U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-35-h0MQHhUuO76tiwTE9YL74Q-1; Wed, 14 Dec 2022 17:19:29 -0500
X-MC-Unique: h0MQHhUuO76tiwTE9YL74Q-1
Received: by mail-ed1-f72.google.com with SMTP id x20-20020a05640226d400b0046cbe2b85caso10384445edd.3
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 14:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+o1xEsC0omMshrEGR2o39o0qaRI2mMB3dbNaYbeBWY=;
        b=yMyt/V2a1j9NrDXlYd5B4JgtI9MVRRJV2GrYAQ42TVKWP+FsnSUZo1jsw9Uu7tM560
         Al6/U0npjjL6l3aPqB7pTo8i05RSXzmvPyNqtv/dt/O5nemsAfX6cDsjSjaMpgmsow4M
         n+ccDgv61qV28XVEuIp3vPVFHWOZhKWUt3QK9HQvYwQ6OVQoS8MR5Xuam/WY6ZIWl4jS
         4upMMEZimF9PHGDpfynFtDmDEf1eyjcpYqBlIlu0suZVvt22dSf9teuquiii8xqOtSAg
         dXikgDxZWzYe2yrtLuhTOhT8SJtT446e6WjRKEW5MnEcmvdLpodbFF7vktHomomVzvUs
         HTrA==
X-Gm-Message-State: ANoB5pnBo49X/QVYbDtTXzjdbSPvvze9vXSMEqAV2Mup0R1zfBuiXqAJ
        BZAoImzEVbW/uubAkv06TKrF0Ob0BdFbmcProtebfewiCajaQwnCLDs9DoeDMBmjj5+16vtaRyu
        UVQtCzcTL0um4
X-Received: by 2002:a17:906:8551:b0:7c1:7045:1a53 with SMTP id h17-20020a170906855100b007c170451a53mr13331845ejy.15.1671056366916;
        Wed, 14 Dec 2022 14:19:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4vQ7ZrQgbylfK+sC6LpLo8ymKH0GND5PAJ1p3Zf+UFzKyh2NnSX/hCNmJR2f87/jHM9kJszA==
X-Received: by 2002:a17:906:8551:b0:7c1:7045:1a53 with SMTP id h17-20020a170906855100b007c170451a53mr13331810ejy.15.1671056366096;
        Wed, 14 Dec 2022 14:19:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id dc20-20020a170906c7d400b007c0f90a9cc5sm6343939ejb.105.2022.12.14.14.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:19:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9263A82F63B; Wed, 14 Dec 2022 23:19:24 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 06/15] bpf: Support consuming XDP HW
 metadata from fext programs
In-Reply-To: <CAKH8qBudP_oZ55ZQe=j+VyOLycvdr+ec7P4pr+ztN9Y-Gv-Waw@mail.gmail.com>
References: <20221213023605.737383-1-sdf@google.com>
 <20221213023605.737383-7-sdf@google.com>
 <1a0436c5-2198-0c69-1306-872454d2fb13@linux.dev> <87cz8mgtcg.fsf@toke.dk>
 <CAKH8qBudP_oZ55ZQe=j+VyOLycvdr+ec7P4pr+ztN9Y-Gv-Waw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Dec 2022 23:19:24 +0100
Message-ID: <87k02tfx1v.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> On Wed, Dec 14, 2022 at 2:41 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Martin KaFai Lau <martin.lau@linux.dev> writes:
>>
>> > On 12/12/22 6:35 PM, Stanislav Fomichev wrote:
>> >> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >>
>> >> Instead of rejecting the attaching of PROG_TYPE_EXT programs to XDP
>> >> programs that consume HW metadata, implement support for propagating =
the
>> >> offload information. The extension program doesn't need to set a flag=
 or
>> >> ifindex, it these will just be propagated from the target by the veri=
fier.
>> >
>> > s/it/because/ ... these will just be propagated....
>>
>> Yeah, or just drop 'it' :)
>>
>> >> We need to create a separate offload object for the extension program,
>> >> though, since it can be reattached to a different program later (which
>> >> means we can't just inhering the offload information from the target).
>> >
>> > hmm.... inheriting?
>>
>> Think I meant to write "we can't just inherit"
>>
>> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> >> index 11c558be4992..8686475f0dbe 100644
>> >> --- a/kernel/bpf/syscall.c
>> >> +++ b/kernel/bpf/syscall.c
>> >> @@ -3021,6 +3021,14 @@ static int bpf_tracing_prog_attach(struct bpf_=
prog *prog,
>> >>                      goto out_put_prog;
>> >>              }
>> >>
>> >> +            if (bpf_prog_is_dev_bound(prog->aux) &&
>> >
>> >
>> >> +                (bpf_prog_is_offloaded(tgt_prog->aux) ||
>> >> +                 !bpf_prog_is_dev_bound(tgt_prog->aux) ||
>> >> +                 !bpf_offload_dev_match(prog, tgt_prog->aux->offload=
->netdev))) {
>> >
>> > hmm... tgt_prog->aux->offload does not look safe without taking bpf_de=
vs_lock.
>> > offload could be NULL, no?
>> >
>> > It probably needs a bpf_prog_dev_bound_match(prog, tgt_prog) which tak=
es the lock.
>>
>> Hmm, right, I was kinda expecting that this would not go away while
>> tgt_prog was alive, but I see now that's not the case due to the
>> unregister hook. So yeah, needs locking (same below) :)
>
> Agreed, thanks! These seem easy enough to address on my side, so I'll
> take care of them (and will keep your attribution).

Awesome, thanks!

-Toke

