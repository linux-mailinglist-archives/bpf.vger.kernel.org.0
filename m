Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BAA455AFB
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbhKRLya (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344267AbhKRLyE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637236264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FeTQh8l0UB/Qy7xEli9YFM7qCxtSruWJQ83NSrruyY=;
        b=AqAJTNK/U+YeVQDXxqLdqBlp6y6HzJjjkNHbPgxk9QoMpyf9aXYh2jIt0fYAnkO9PirrmI
        QwwMy27C5GSsFftXwoLI38bKGuX4UZnnwpPKXZt010ZCk0ZFItl3bmx6S5Nu3t0SlQOlhl
        0hg2oa+VpUWMdHbb1JB0i2pvtopGIrk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-TGSYqK-LN-aOGgO_6kZDUQ-1; Thu, 18 Nov 2021 06:51:02 -0500
X-MC-Unique: TGSYqK-LN-aOGgO_6kZDUQ-1
Received: by mail-ed1-f71.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso3077519edq.19
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5FeTQh8l0UB/Qy7xEli9YFM7qCxtSruWJQ83NSrruyY=;
        b=da/ZusiPBSyo+Xh4SNJ6WmW7RfJK4noPdHCNpcOsrur+cvV/4P4Rk8+8t+S+qQ4lIB
         XrJmUuHZHvIHz2sL23pQOf0XWK8Siux1WMoCAotEzWc9iw5nOM+io4oygBThcWGeJaAx
         BPUVjTNMNE+cP+4hwfunAabgSPgt03gY8tlFnSMcA08yp6BO0n8cLScr4saGgAh0GAey
         tHzalXYDauwK4a1T6cuIpwCybra8a2Mcd0IWBoW8hhgeZJtqlvsK3EnA9JvK4ALWd7Cv
         A3bG1xYBWITf/04DmE8y41RE9MpbileysicojzRhQZ/ubpNI7ZQZXkGu23FbvrY4t7ju
         NZtA==
X-Gm-Message-State: AOAM531pKuZHWBjrxdFDyn3Ohxsrv3iXYqZtFXylVavP5Nz3ZGynM9dE
        jdcyAs0W0WF6VQAYpKy0ZVlZ2TjNDI/7WI7qPX8roC+/ICVeacOcv5w2aWzEYmN7/SsljN5Jpjj
        ZDCtwohLcK7Hy
X-Received: by 2002:a17:907:7da9:: with SMTP id oz41mr6980900ejc.57.1637236261242;
        Thu, 18 Nov 2021 03:51:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyO84E8OlZ9tmyaesOQsrlVDvBMvqPKXc7Zrfnz1KaziFgM4RPX9U8AutSq2CG1L3q/wN/71Q==
X-Received: by 2002:a17:907:7da9:: with SMTP id oz41mr6980842ejc.57.1637236260849;
        Thu, 18 Nov 2021 03:51:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gt18sm1178792ejc.88.2021.11.18.03.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:51:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8383A180270; Thu, 18 Nov 2021 12:50:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] bpf: let bpf_warn_invalid_xdp_action() report
 more info
In-Reply-To: <8deb249146474aff37cc574e464615cf98adb32e.camel@redhat.com>
References: <cover.1636987322.git.pabeni@redhat.com>
 <c48e1392bdb0937fd33d3524e1c955a1dae66f49.1636987322.git.pabeni@redhat.com>
 <8735nxo08o.fsf@toke.dk>
 <1b9bf5f4327699c74f93c297433012400769a60f.camel@redhat.com>
 <87zgq5mjlj.fsf@toke.dk> <20211118004852.tn2jewjm55dwwa5y@ast-mbp>
 <8deb249146474aff37cc574e464615cf98adb32e.camel@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 18 Nov 2021 12:50:58 +0100
Message-ID: <87o86hel7h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> writes:

> Hello,
>
> On Wed, 2021-11-17 at 16:48 -0800, Alexei Starovoitov wrote:
>> On Mon, Nov 15, 2021 at 06:09:28PM +0100, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>> > Paolo Abeni <pabeni@redhat.com> writes:
>> >=20
>> > > > > -	pr_warn_once("%s XDP return value %u, expect packet loss!\n",
>> > > > > +	pr_warn_once("%s XDP return value %u on prog %d dev %s attach =
type %d, expect packet loss!\n",
>> > > > >  		     act > act_max ? "Illegal" : "Driver unsupported",
>> > > > > -		     act);
>> > > > > +		     act, prog->aux->id, dev->name, prog->expected_attach_typ=
e);
>> > > >=20
>> > > > This will only ever trigger once per reboot even if the message di=
ffers,
>> > > > right? Which makes it less useful as a debugging aid; so I'm not s=
ure if
>> > > > it's really worth it with this intrusive change unless we also do
>> > > > something to add a proper debugging aid (like a tracepoint)...
>> > >=20
>> > > Yes, the idea would be to add a tracepoint there, if there is general
>> > > agreement about this change.
>> > >=20
>> > > I think this patch is needed because the WARN_ONCE splat gives
>> > > implicitly information about the related driver and attach type.
>> > > Replacing with a simple printk we lose them.
>> >=20
>> > Ah, right, good point. Pointing that out in the commit message might be
>> > a good idea; otherwise people may miss that ;)
>>=20
>> Though it's quite a churn across the drivers I think extra verbosity her=
e is justified.
>> I'd only suggest to print stable things. Like prog->aux->id probably has
>> little value for the person looking at the logs. That prog id is likely =
gone.
>> If it was prog->aux->name it would be more helpful.
>> Same with expected_attach_type. Why print it at all?
>> tracepoint is probably good idea too.
>
> Thanks for the feedback.
>
> I tried to select the additional arguments to allow the user/admin
> tracking down which program is causing the issue and why. I'm a
> complete newbe wrt XDP, so likely my choice were naive.
>
> I thought the id identifies the program in an unambiguous manner. I
> understand the program could be unloaded meanwhile, but if that is not
> the case the id should be quite useful. Perhaps we could dump both the
> id and the name?
>
> I included the attach type as different types support/allow different
> actions: the same program could cause the warning or not depending on
> it. If that is not useful I can drop the attach type from the next
> iteration.

The attach type identifies DEVMAP and CPUMAP programs, but just printing
it as a number probably doesn't make sense. So maybe something like:

switch(prog->expected_attach_type) {
    case BPF_XDP_DEVMAP:
    case BPF_XDP_CPUMAP:
      pr_warn_once("Illegal XDP return value %u from prog %s(%d) in %s!\n",
                   act, prog->aux_name, prog->aux->id,
                   prog->expected_attach_type =3D=3D BPF_XDP_DEVMAP ? "devm=
ap" : "cpumap");
      break;
    default:
      pr_warn_once("%s XDP return value %u on prog %s(%d) dev %s, expect pa=
cket loss!\n",
                   act > act_max ? "Illegal" : "Driver unsupported",
                   act, prog->aux->name, prog->aux->id, dev->name);
      break;
}=20=20=20=20=20=20

-Toke

