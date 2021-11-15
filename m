Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B24450ABD
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 18:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhKOROU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 12:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236756AbhKORMd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Nov 2021 12:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636996177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wscZ0cgeMoeQ6rtb9cbLe3FKWGxA97hDuF+nauPvdro=;
        b=GnlsQbFYPrkgczbNEAcB8CG1O7fnodYCNUBE8YeTceWifkThFk5FEASpi7nPMndvG6AILo
        sdsC131S8Z5aFtgf/vDvz9pPK8sc5zmBv47vOkUZVF9EI4H8250APWfglpBg1bq1+p+pfR
        eS38o8gP2GMsfhlB6lO7L3V+fYnr9hM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-Bwlr8KxpNpa_Ci4jjKBvQA-1; Mon, 15 Nov 2021 12:09:36 -0500
X-MC-Unique: Bwlr8KxpNpa_Ci4jjKBvQA-1
Received: by mail-il1-f200.google.com with SMTP id d8-20020a928748000000b0027585828bc3so10980373ilm.7
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 09:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wscZ0cgeMoeQ6rtb9cbLe3FKWGxA97hDuF+nauPvdro=;
        b=GKvd2D1Bp+DS/DO03hptJ8IvlzgXFTBgVxMWl4jqwqGB9+meHEzWvvqgD1Rn1x7Jvj
         EyMZ/Uck2aUETn61Z+OI5urJ0vOWRhntlxMYMZsQuMkmvVQjucppXUpdniOWubUGy8eT
         SduzhMeUWLegxelK1CMalJ57sMtxtcjpScXriMfB1sl/wUNWLfIGrxEN8ZgOSY8vRZYa
         dCHE0u/LNj8D8oeNryJ5pVsD981cV+PdH8zXvsqMoCCL3Id1FNKUmKuis6pm993e3vF1
         uDPDpbZspO0l5xWIX0c2noHU6dPlLe0VlaCG1oQqHSIeMbajJ3Pos4aWdIrUzCtvmufc
         MDfQ==
X-Gm-Message-State: AOAM532pkenGz5FOO3U80ukhl2NEWPRAAZJTnCLqxzwaptpfpQJ8lPF8
        G9cNGxKFNgLyS54KotPhu1x4xB3Mk3eqXctDq9E5WJ337H4bIY3JeuHuA20HNEOHFw5IXiQimGn
        oX6PlQTXpOaD0
X-Received: by 2002:a5e:9918:: with SMTP id t24mr234703ioj.161.1636996174268;
        Mon, 15 Nov 2021 09:09:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIq1SSOWARdDNhtSTT3PjZXFYqHRPnZwgI+hWF++rvFF1LFklRt/iRLXkUW/lJMDGY+eTpaw==
X-Received: by 2002:a5e:9918:: with SMTP id t24mr234588ioj.161.1636996172536;
        Mon, 15 Nov 2021 09:09:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s17sm10547264iln.44.2021.11.15.09.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 09:09:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C667E18026E; Mon, 15 Nov 2021 18:09:28 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] bpf: let bpf_warn_invalid_xdp_action() report
 more info
In-Reply-To: <1b9bf5f4327699c74f93c297433012400769a60f.camel@redhat.com>
References: <cover.1636987322.git.pabeni@redhat.com>
 <c48e1392bdb0937fd33d3524e1c955a1dae66f49.1636987322.git.pabeni@redhat.com>
 <8735nxo08o.fsf@toke.dk>
 <1b9bf5f4327699c74f93c297433012400769a60f.camel@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 15 Nov 2021 18:09:28 +0100
Message-ID: <87zgq5mjlj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> writes:

>> > -	pr_warn_once("%s XDP return value %u, expect packet loss!\n",
>> > +	pr_warn_once("%s XDP return value %u on prog %d dev %s attach type %d, expect packet loss!\n",
>> >  		     act > act_max ? "Illegal" : "Driver unsupported",
>> > -		     act);
>> > +		     act, prog->aux->id, dev->name, prog->expected_attach_type);
>> 
>> This will only ever trigger once per reboot even if the message differs,
>> right? Which makes it less useful as a debugging aid; so I'm not sure if
>> it's really worth it with this intrusive change unless we also do
>> something to add a proper debugging aid (like a tracepoint)...
>
> Yes, the idea would be to add a tracepoint there, if there is general
> agreement about this change.
>
> I think this patch is needed because the WARN_ONCE splat gives
> implicitly information about the related driver and attach type.
> Replacing with a simple printk we lose them.

Ah, right, good point. Pointing that out in the commit message might be
a good idea; otherwise people may miss that ;)

-Toke

