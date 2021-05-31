Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9971A395966
	for <lists+bpf@lfdr.de>; Mon, 31 May 2021 13:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhEaLFB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 May 2021 07:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230521AbhEaLFA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 31 May 2021 07:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622459000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NzhPc2/VJnV/S2AtxpaMAKHXur4j7tjmTtbLyErDxvQ=;
        b=SRiCn6rXXXwuZj2EwHKrrLJ87HQyxfbe/Pxu3Xu+n0jRIztSpHLP/yE8zXzAVa+fsHPTsI
        1Lk37VXlQkvBXC5Pg+HWoj0XPmVAn5hxfRh4QqDU/zHFTSQLqx3Z/8vu2bQhaNqWhRNpB7
        543+uBFh8XjEc67jqXP+lb7DbROZZik=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-1SNnxSMWO7CZwCPICzVyPA-1; Mon, 31 May 2021 07:03:19 -0400
X-MC-Unique: 1SNnxSMWO7CZwCPICzVyPA-1
Received: by mail-ed1-f71.google.com with SMTP id h16-20020a0564020950b029038cbdae8cbaso6058500edz.6
        for <bpf@vger.kernel.org>; Mon, 31 May 2021 04:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NzhPc2/VJnV/S2AtxpaMAKHXur4j7tjmTtbLyErDxvQ=;
        b=aMgD7pEdvM8pz3FQVKlk8cmk6PyEOnJsW3Sy+g3CqisVJPyE/HL82kovpBR92KR6+i
         XzmSpUA/3JjZWKtIq6nM8puUNt63MTaZRKM7xLDfGF1BFwLgdmYRbrofIq+UavIBKpvK
         Q6+V+AmrFkoW+bhgsU7g+joTHvwHq9AguUhsEY9wLp+EuWy/EOxxORPPru/Tco6t9aKd
         XpK5fkjl8Y9/oD2XIXNCTtRZ3F2o90GekGujlNJpUcKQ8YYJ8Tv9IbbPYyCI+0ke9UEt
         ULBjgKaeLdwdC+MkJEZIi8Y5GPL2Yku/B0AbcrkAuyaiezq8G6uamvv0MOrJhkpDdR3d
         e80w==
X-Gm-Message-State: AOAM531eLv6Z7x/paClBvm/wYPBgN8LLu8o6rcdknkP/TnbLeNs3yiPw
        IqOqjv2UO+6xGmfwy23S3h7QemA3C3ehU8LTSqbv55DLLKZ+3p7doXLLSp2ZXVQ8FgIJfaeX8TA
        YS4shWhIAlvZj
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr24615597edd.101.1622458997822;
        Mon, 31 May 2021 04:03:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwndPFlfmr8B8U3juxZhuNbPa3F3JaNZeBpn6GkzZhPvKRPhXlkNJGepQcV5s3zSaruPii5kQ==
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr24615553edd.101.1622458997444;
        Mon, 31 May 2021 04:03:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bq1sm1414775ejb.66.2021.05.31.04.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 04:03:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 04C75180724; Mon, 31 May 2021 13:03:15 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
In-Reply-To: <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
References: <20210526125848.1c7adbb0@carbon>
 <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
 <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
 <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
 <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
 <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk>
 <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon>
 <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 31 May 2021 13:03:14 +0200
Message-ID: <8735u3dv2l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Jesper Dangaard Brouer wrote:
>
> [...]
>
> I'll try to respond to both Toke and Jesper here and make it coherent so
> we don't split this thread yet again.
>
> Wish me luck.
>
> @Toke "react" -> "not break" hopefully gives you my opinion on this.
>
> @Toke "five fields gives 32 different metadata formats" OK let me take
> five fields,
>
>  struct meta {
>    __u32 f1;
>    __u32 f2;
>    __u32 f3;
>    __u32 f4;
>    __u32 f5;
>  }
>
> I'm still confused why the meta data would change just because the feature
> is enabled or disabled. I've written drivers before and I don't want to
> move around where I write f1 based on some combination of features f2,f3,f4,f5
> state of enabled/disabled. If features are mutual exclusive I can build a
> sensible union. If its possible for all fields to enabled then I just lay
> them out like above.

The assumption that the layout would be changing as the features were
enabled came from a discussion I had with Jesper where he pointed out
that zeroing out the fields that were not active comes with a measurable
performance impact. So changing the struct layout to only include the
fields that are currently used is a way to make sure we don't hurt
performance.

If I'm understanding you correctly, what you propose instead is that we
just keep the struct layout the same and only write the data that we
have, leaving the other fields as uninitialised (so essentially
garbage), right?

If we do this, the BPF program obviously needs to know which fields are
valid and which are not. AFAICT you're proposing that this should be
done out-of-band (i.e., by the system administrator manually ensuring
BPF program config fits system config)? I think there are a couple of
problems with this:

- It requires the system admin to coordinate device config with all of
  their installed XDP applications. This is error-prone, especially as
  the number of applications grows (say if different containers have
  different XDP programs installed on their virtual devices).

- It has synchronisation issues. Say I have an XDP program with optional
  support for hardware timestamps and a software fallback. It gets
  installed in software fallback mode; then the admin has to make sure
  to enable the hardware timestamps before switching the application
  into the mode where it will read that metadata field (and the opposite
  order when disabling the hardware mode).

Also, we need to be able to deal with different metadata layouts on
different packets in the same program. Consider the XDP program running
on a veth device inside a container above: if this gets packets
redirected into it from different NICs with different layouts, it needs
to be able to figure out which packet came from where.

With this in mind I think we have to encode the metadata format into the
packet metadata itself somehow. This could just be a matter of including
the BTF ID as part of the struct itself, so that your example could
essentially do:

  if (data->meta_btf_id == timestamp_id) {
    struct timestamp_meta *meta = data->meta_data;
    // do stuff
  } else {
    struct normal_meta *meta = data->meta_data;
  }


and then, to avoid drivers having to define different layouts we could
essentially have the two metadata structs be:

 struct normal_meta {
  u32 rxhash;
  u32 padding;
  u8 vlan;
 };

and

 struct timestamp_meta {
   u32 rxhash;
   u32 timestamp;
   u8 vlan;
 };

This still gets us exponential growth in the number of metadata structs,
but at least we could create tooling to auto-generate the BTF for the
variants so the complexity is reduced to just consuming a lot of BTF
IDs.

Alternatively we could have an explicit bitmap of valid fields, like:

 struct all_meta {
   u32 _valid_field_bitmap;
   u32 rxhash;
   u32 timestamp;
   u8 vlan;
 };

and if a program reads all_meta->timestamp CO-RE could transparently
insert a check of the relevant field in the bitmap first. My immediate
feeling is that this last solution would be nicer: We'd still need to
include the packet BTF ID in the packet data to deal with case where
packets are coming from different interfaces, but we'd avoid having lots
of different variants with separate BTF IDs. I'm not sure what it would
take to teach CO-RE to support such a scheme, though...

WDYT?

-Toke

