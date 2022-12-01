Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C99863F213
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiLANwu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 08:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiLANwr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 08:52:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26F3209BB
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669902709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0B3skIFK8P8iPGJftFbk/4SE5J8WNbj6vIv8u9UcMac=;
        b=DpjvMXkCQ8Rdl7lSi+iDma6cK2xtDKbjub2UCls0yzIvx0P0vK0KHZWSpWHZRI4qA2H+ky
        B0equQWWVauvSbNg5p741Mg6F2SHCUqUMsveFh2NBjQ6+uJs4HOEoSom3kbLIVy1OwCTS6
        CvXZztyWXbJ2ufTGSmJnhJwfL+3h6cs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-sRNh5MWXM4mXibXjULdd-Q-1; Thu, 01 Dec 2022 08:51:46 -0500
X-MC-Unique: sRNh5MWXM4mXibXjULdd-Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF3A2857F8F;
        Thu,  1 Dec 2022 13:51:45 +0000 (UTC)
Received: from wtfbox.lan (ovpn-193-104.brq.redhat.com [10.40.193.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21DB3492B11;
        Thu,  1 Dec 2022 13:51:44 +0000 (UTC)
Date:   Thu, 1 Dec 2022 14:51:41 +0100
From:   Artem Savkov <asavkov@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: Calling kfuncs in modules - BTF mismatch?
Message-ID: <Y4ixbdi499r1Cz61@wtfbox.lan>
References: <87leoh372s.fsf@toke.dk>
 <CAJ0CqmWO-MsjL3i6pfATJ=JakbnTfQmwKmruz9zEM_H-sz1_uA@mail.gmail.com>
 <875yfiwx1g.fsf@toke.dk>
 <Y4Yeom8vSZtBM3o2@wtfbox.lan>
 <877czdzfid.fsf@toke.dk>
 <CAEf4Bza2xDZ45kxxa3dg1C_RWE=UB5UFYEuFp6rbXgX=LRHv-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza2xDZ45kxxa3dg1C_RWE=UB5UFYEuFp6rbXgX=LRHv-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 30, 2022 at 05:09:03PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 29, 2022 at 12:12 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > >> > This week Kumar and I took a look at this issue and we ended up
> > >> > identifying a duplication of nf_conn___init structure. In particular:
> > >> >
> > >> > [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
> > >> > net/netfilter/nf_conntrack.ko format raw | grep nf_conn__
> > >> > [110941] STRUCT 'nf_conn___init' size=248 vlen=1
> > >> > [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
> > >> > net/netfilter/nf_nat.ko format raw | grep nf_conn__
> > >> > [107488] STRUCT 'nf_conn___init' size=248 vlen=1
> > >> >
> > >> > Is it the root cause of the problem?
> > >>
> > >> It certainly seems to be related to it, at least. Amending the log
> > >> message to include the BTF object IDs of the two versions shows that the
> > >> register has a reference to nf_conn__init in nf_conntrack.ko, while the kernel
> > >> expects it to point to nf_nat.ko.
> > >>
> > >> Not sure what's the right fix for this? Should libbpf be smart enough to
> > >> pull the kfunc arg ID from the same BTF ID as the function itself? Or
> 
> Libbpf is doing just that. Or rather this just happens automatically.
> Libbpf finds the FUNC type corresponding to a kfunc, and then all the
> types of all the arguments are consistent with that FUNC definition.
> 
> I think the problem is that test is getting `struct nf_conn` from
> bpf_xdp_ct_alloc() kfunc, which is defined in nf_conntrack module (and
> so specifies that it returns `struct nf_conn` coming from
> nf_conntrack's module BTF), while bpf_ct_set_nat_info() kfunc is
> defined in nf_nat module and specifies that it expects `struct
> nf_conn` defined in nf_nat's module BTF.
> 
> And those two types are two completely different types, with different
> BTF object ID and BTF type ID, as far as all the BTF stuff is
> concerned.
> 
> I don't know what the solution here is, but it's not on the libbpf
> side at all for sure. As Toke said, bringing BTF dedup into the kernel
> seems like an overkill. So some hacky "let's compare struct name and
> size" approach perhaps?

Wouldn't that be a bit too relaxed for a general case? I wonder how
often can this issue come up. If this is relatively rare maybe known
kfuncs that need this can be flagged with a new flag
(KF_RELAXED_ARG_CHECK or similar) to allow this shortcut?

-- 
Regards,
  Artem

