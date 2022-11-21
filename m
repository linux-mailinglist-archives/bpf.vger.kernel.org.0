Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2F632C29
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKUSfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 13:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKUSfD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 13:35:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49794D08BA
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 10:35:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2BC0B81236
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C54C433D6;
        Mon, 21 Nov 2022 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669055699;
        bh=eHkp2wY2k51bbOuHdSd+5ueSBvfi/w73HWrbedxZaOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dygGccb0Sf4b7nhvq2kHUuyJxprz8HfyEL5JANP+McCI7QR9Q412y0lc78P/XBe5Z
         fJoW+ebhUAW3WJtKznTO6MKfeAsK0GQPVsW7hWkAu3KHkPYpj0/NGlCSrKDeriTKWW
         +3WLSUTB4tRA0NDyvT/EzonfOt3tTAU3cVNnnXNXJO+zd+azXVXt/vlZW4sTsrKtQR
         0tN1wKlOIJEVrAM45sQfV7HtG9OQsTn6tXzqB36+1rVsUHE7adiII915f6body7jJ5
         Y8+7hgzA+pe6ztCjE8+BVuvMGVwkxQao8NAKdim4UW2exH//XCAlPXmTM2ugI79b2/
         KfHP4A4Ktjg+Q==
Date:   Mon, 21 Nov 2022 11:34:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v10 16/24] bpf: Introduce single ownership BPF
 linked list API
Message-ID: <Y3vE0T3BRxKZYgnb@dev-arch.thelio-3990X>
References: <20221118015614.2013203-1-memxor@gmail.com>
 <20221118015614.2013203-17-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118015614.2013203-17-memxor@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kumar,

On Fri, Nov 18, 2022 at 07:26:06AM +0530, Kumar Kartikeya Dwivedi wrote:
> Add a linked list API for use in BPF programs, where it expects
> protection from the bpf_spin_lock in the same allocation as the
> bpf_list_head. For now, only one bpf_spin_lock can be present hence that
> is assumed to be the one protecting the bpf_list_head.
> 
> The following functions are added to kick things off:
> 
> // Add node to beginning of list
> void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node);
> 
> // Add node to end of list
> void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node);
> 
> // Remove node at beginning of list and return it
> struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head);
> 
> // Remove node at end of list and return it
> struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head);
> 
> The lock protecting the bpf_list_head needs to be taken for all
> operations. The verifier ensures that the lock that needs to be taken is
> always held, and only the correct lock is taken for these operations.
> These checks are made statically by relying on the reg->id preserved for
> registers pointing into regions having both bpf_spin_lock and the
> objects protected by it. The comment over check_reg_allocation_locked in
> this change describes the logic in detail.
> 
> Note that bpf_list_push_front and bpf_list_push_back are meant to
> consume the object containing the node in the 1st argument, however that
> specific mechanism is intended to not release the ref_obj_id directly
> until the bpf_spin_unlock is called. In this commit, nothing is done,
> but the next commit will be introducing logic to handle this case, so it
> has been left as is for now.
> 
> bpf_list_pop_front and bpf_list_pop_back delete the first or last item
> of the list respectively, and return pointer to the element at the
> list_node offset. The user can then use container_of style macro to get
> the actual entry type. The verifier however statically knows the actual
> type, so the safety properties are still preserved.
> 
> With these additions, programs can now manage their own linked lists and
> store their objects in them.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Apologies if this has already been reported or discussed somewhere else;
I did a search of the mailing list and did find a sparse report that
seems to be complaining about this same issue but it does not look like
you were cc'd on that [1].

This commit is now in -next as commit 8cab76ec6349 ("bpf: Introduce
single ownership BPF linked list API") and I just bisected a new series
of warnings I see with clang as starting with this change; Yonghong's
recent "bpf: Implement two type cast kfuncs" [2] added a couple more but
they start here. When CONFIG_DEBUG_INFO_BTF is disabled (as is the case
with allmodconfig), I see the following clang warnings at this change:

    ../kernel/bpf/verifier.c:8340:19: error: array index 5 is past the end of the array (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
                   btf_id == special_kfunc_list[KF_bpf_list_pop_back];
                             ^                  ~~~~~~~~~~~~~~~~~~~~
    ../kernel/bpf/verifier.c:8113:1: note: array 'special_kfunc_list' declared here
    BTF_ID_LIST(special_kfunc_list)
    ^
    ../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
    #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                              ^
    ../kernel/bpf/verifier.c:8819:24: error: array index 5 is past the end of the array (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
                                       meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
                                                       ^                  ~~~~~~~~~~~~~~~~~~~~
    ../kernel/bpf/verifier.c:8113:1: note: array 'special_kfunc_list' declared here
    BTF_ID_LIST(special_kfunc_list)
    ^
    ../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
    #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                              ^
    2 errors generated.

At ToT -next (next-20221121), I see:

    ../kernel/bpf/verifier.c:8196:23: error: array index 6 is past the end of the array (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
            if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
                                 ^                  ~~~~~~~~~~~~~~~~~~~~~~~
    ../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
    BTF_ID_LIST(special_kfunc_list)
    ^
    ../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
    #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                              ^
    ../kernel/bpf/verifier.c:8443:19: error: array index 5 is past the end of the array (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
                   btf_id == special_kfunc_list[KF_bpf_list_pop_back];
                             ^                  ~~~~~~~~~~~~~~~~~~~~
    ../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
    BTF_ID_LIST(special_kfunc_list)
    ^
    ../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
    #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                              ^
    ../kernel/bpf/verifier.c:8686:25: error: array index 6 is past the end of the array (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
                            if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
                                                 ^                  ~~~~~~~~~~~~~~~~~~~~~~~
    ../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
    BTF_ID_LIST(special_kfunc_list)
    ^
    ../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
    #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                              ^
    ../kernel/bpf/verifier.c:8938:24: error: array index 5 is past the end of the array (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
                                       meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
                                                       ^                  ~~~~~~~~~~~~~~~~~~~~
    ../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
    BTF_ID_LIST(special_kfunc_list)
    ^
    ../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
    #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                              ^
    ../kernel/bpf/verifier.c:8946:31: error: array index 6 is past the end of the array (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
                            } else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
                                                       ^                  ~~~~~~~~~~~~~~~~~~~~~~~
    ../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
    BTF_ID_LIST(special_kfunc_list)
    ^
    ../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
    #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                              ^
    ../kernel/bpf/verifier.c:8951:31: error: array index 7 is past the end of the array (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
                            } else if (meta.func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
                                                       ^                  ~~~~~~~~~~~~~~~~~~
    ../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
    BTF_ID_LIST(special_kfunc_list)
    ^
    ../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
    #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                              ^
    ../kernel/bpf/verifier.c:15216:30: error: array index 6 is past the end of the array (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
            } else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
                                        ^                  ~~~~~~~~~~~~~~~~~~~~~~~
    ../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
    BTF_ID_LIST(special_kfunc_list)
    ^
    ../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
    #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                              ^
    ../kernel/bpf/verifier.c:15217:23: error: array index 7 is past the end of the array (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
                       desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
                                        ^                  ~~~~~~~~~~~~~~~~~~
    ../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
    BTF_ID_LIST(special_kfunc_list)
    ^
    ../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
    #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
                              ^
    8 errors generated.

Somewhat surprisingly, I do not see these with GCC 11 (-Warray-bounds is
explicitly disabled for GCC 12) but I do not see how they could not be
legitimate, unless all this code gets optimized away when
CONFIG_DEBUG_INFO_BTF is disabled, which I could be missing. Any reason
that the fix is not something like:

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index c9744efd202f..71d0ce707744 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -204,7 +204,7 @@ extern struct btf_id_set8 name;
 
 #else
 
-#define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
+#define BTF_ID_LIST(name) static u32 __maybe_unused name[8];
 #define BTF_ID(prefix, name)
 #define BTF_ID_FLAGS(prefix, name, ...)
 #define BTF_ID_UNUSED

I suppose that there should probably be some sort of assertion to catch
this discrepancy in the future.

Cheers,
Nathan

[1]: https://lore.kernel.org/202211190612.qFDcJqqt-lkp@intel.com/
[2]: https://lore.kernel.org/20221120195421.3112414-1-yhs@fb.com/

# bad: [e4cd8d3ff7f9efeb97330e5e9b99eeb2a68f5cf9] Add linux-next specific files for 20221121
# good: [894909f95aa1473f49f767dcd5750ba152b85e13] Merge tag 'x86_urgent_for_v6.1_rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect start 'e4cd8d3ff7f9efeb97330e5e9b99eeb2a68f5cf9' '894909f95aa1473f49f767dcd5750ba152b85e13'
# bad: [42c3120ba7547d18e7788707e67ff01dc220f09b] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad 42c3120ba7547d18e7788707e67ff01dc220f09b
# good: [ceda86b061181705d751fce5971da7da32aa9afc] Merge branch 'master' of https://github.com/Paragon-Software-Group/linux-ntfs3.git
git bisect good ceda86b061181705d751fce5971da7da32aa9afc
# good: [c609d739947894d7370eae4cf04eb2c49e910bcf] Merge tag 'wireless-next-2022-11-18' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
git bisect good c609d739947894d7370eae4cf04eb2c49e910bcf
# good: [4b39aeeaec47f5cea7f6ab76fa2da428e4bf5c7e] Merge branch 'master' of git://linuxtv.org/media_tree.git
git bisect good 4b39aeeaec47f5cea7f6ab76fa2da428e4bf5c7e
# good: [4c071062e639f74d95a229b5efc22cb1c9ed3d49] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 4c071062e639f74d95a229b5efc22cb1c9ed3d49
# bad: [8d72bd74ae946456865574a0390979af5aa74bcb] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git bisect bad 8d72bd74ae946456865574a0390979af5aa74bcb
# bad: [e181d3f143f7957a73c8365829249d8084602606] bpf: Disallow bpf_obj_new_impl call when bpf_mem_alloc_init fails
git bisect bad e181d3f143f7957a73c8365829249d8084602606
# good: [f73e601aafb2ad9f2b2012b969f86f4a41141a7d] bpf: Populate field_offs for inner_map_meta
git bisect good f73e601aafb2ad9f2b2012b969f86f4a41141a7d
# bad: [64069c72b4b8e44f6876249cc8f2e2ee4d209a93] selftests/bpf: Add __contains macro to bpf_experimental.h
git bisect bad 64069c72b4b8e44f6876249cc8f2e2ee4d209a93
# good: [00b85860feb809852af9a88cb4ca8766d7dff6a3] bpf: Rewrite kfunc argument handling
git bisect good 00b85860feb809852af9a88cb4ca8766d7dff6a3
# good: [df57f38a0d081f05ec48ea5aa7ca0564918ed915] bpf: Permit NULL checking pointer with non-zero fixed offset
git bisect good df57f38a0d081f05ec48ea5aa7ca0564918ed915
# bad: [534e86bc6c66e1e0c798a1c0a6a680bb231c08db] bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
git bisect bad 534e86bc6c66e1e0c798a1c0a6a680bb231c08db
# bad: [8cab76ec634995e59a8b6346bf8b835ab7fad3a3] bpf: Introduce single ownership BPF linked list API
git bisect bad 8cab76ec634995e59a8b6346bf8b835ab7fad3a3
# first bad commit: [8cab76ec634995e59a8b6346bf8b835ab7fad3a3] bpf: Introduce single ownership BPF linked list API
