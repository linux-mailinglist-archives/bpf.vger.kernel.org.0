Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6FD646179
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 20:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLGTG3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 14:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLGTGK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 14:06:10 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F9576147
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 11:05:36 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d82so9541694pfd.11
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 11:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3cwOhs43MILDXWtH3T9tGsv0o4TUpW+M/BIsXwboa8=;
        b=BrYM633vYpxeSw26gPFg3TO2eZf08UBcifmNjEB4MmLAslZR2Cq/Sa3RKMhXR2p/PH
         lZbF3yIG0Hovv4SC4WO3lybvjCQd7TjjnX/hqeCGNNGfiR5o7t1AKYrLfVd74ZAq1sBE
         L5y+rM2XF0GpRelmvaf2lZk388xHf4Jan2Yqo50gWD/MiyG06DyoSGsqJgcK8IR3STRq
         9JLHhHJN7/NWofUb0w0doQH1oVyCHVlHeFtXwDbEff90odA34zPBGwZuZTdtpaQ0BAOb
         vvG3dVcdDlhceBLhns7wX0NZlbmBfgEWVLhigRNrgSu6iHvSrobELObCuzkSeRt8N2nJ
         Zveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3cwOhs43MILDXWtH3T9tGsv0o4TUpW+M/BIsXwboa8=;
        b=GRRn8rg52EvOOPMma5vwbASylwTqTy8GFFGP3hk2IX1PmXpQibatk1ltELlwQu2cvg
         4fHcnQ16vhInnaXdnQyP2J3yk97SpVjjEP3J5jKfJazsU3oVIyKB6LnR561y4xdJ0yxc
         tE+jlIF3MvSJrWGOZECw4XXXl2uKYHYaU6zwS1DE5EVYgMBRmrcFGO3QgD1Z7kYOByXX
         TVETblU4MVcALfHc7TJi3EBxUIEj0ol7diWYi/Hl5IFrOIJacss7W8I9m8qrdwfmmfKv
         sq9ezhH5PhHMiY67/ZxhfQKBwqHRxpMgTDJWGM0N8LzcsNoyMLaDoLSUPBu5m563xqwG
         1/eg==
X-Gm-Message-State: ANoB5pmR/AoYshnbmAlga22+PST9i328HnnY3SO4xiWIIowcPi5L82Vi
        ZUgPwvGukAXUD6WDkxWiTKQ=
X-Google-Smtp-Source: AA0mqf7NoDY6duDio9XE8Rfn8TSFjcmykJQGUyth++fxQCE250BhICUD7mnMci97IVOPCwZw9hVzkw==
X-Received: by 2002:a62:1687:0:b0:574:e5aa:a8dd with SMTP id 129-20020a621687000000b00574e5aaa8ddmr905687pfw.17.1670439936226;
        Wed, 07 Dec 2022 11:05:36 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79f94000000b005745788f44csm13881940pfr.124.2022.12.07.11.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:05:35 -0800 (PST)
Date:   Wed, 7 Dec 2022 11:05:33 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 02/13] bpf: map_check_btf should fail if
 btf_parse_fields fails
Message-ID: <20221207190533.vlfg33metstbcpik@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-3-davemarchevsky@fb.com>
 <20221207164900.mqxvvw4thxldg4vo@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207164900.mqxvvw4thxldg4vo@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 10:19:00PM +0530, Kumar Kartikeya Dwivedi wrote:
> On Wed, Dec 07, 2022 at 04:39:49AM IST, Dave Marchevsky wrote:
> > map_check_btf calls btf_parse_fields to create a btf_record for its
> > value_type. If there are no special fields in the value_type
> > btf_parse_fields returns NULL, whereas if there special value_type
> > fields but they are invalid in some way an error is returned.
> >
> > An example invalid state would be:
> >
> >   struct node_data {
> >     struct bpf_rb_node node;
> >     int data;
> >   };
> >
> >   private(A) struct bpf_spin_lock glock;
> >   private(A) struct bpf_list_head ghead __contains(node_data, node);
> >
> > groot should be invalid as its __contains tag points to a field with
> > type != "bpf_list_node".
> >
> > Before this patch, such a scenario would result in btf_parse_fields
> > returning an error ptr, subsequent !IS_ERR_OR_NULL check failing,
> > and btf_check_and_fixup_fields returning 0, which would then be
> > returned by map_check_btf.
> >
> > After this patch's changes, -EINVAL would be returned by map_check_btf
> > and the map would correctly fail to load.
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Fixes: aa3496accc41 ("bpf: Refactor kptr_off_tab into btf_record")
> > ---
> >  kernel/bpf/syscall.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 35972afb6850..c3599a7902f0 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1007,7 +1007,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
> >  	map->record = btf_parse_fields(btf, value_type,
> >  				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD,
> >  				       map->value_size);
> > -	if (!IS_ERR_OR_NULL(map->record)) {
> > +	if (IS_ERR(map->record))
> > +		return -EINVAL;
> > +
> 
> I didn't do this on purpose, because of backward compatibility concerns. An
> error has not been returned in earlier kernel versions during map creation time
> and those fields acted like normal non-special regions, with errors on use of
> helpers that act on those fields.
> 
> Especially that bpf_spin_lock and bpf_timer are part of the unified btf_record.
> 
> If we are doing such a change, then you should also drop the checks for IS_ERR
> in verifier.c, since that shouldn't be possible anymore. But I think we need to
> think carefully before changing this.
> 
> One possible example is: If we introduce bpf_foo in the future and program
> already has that defined in map value, using it for some other purpose, with
> different alignment and size, their map creation will start failing.

That's a good point.
If we can error on such misconstructed map at the program verification time that's better
anyway, since there will be a proper verifier log instead of EINVAL from map_create.
