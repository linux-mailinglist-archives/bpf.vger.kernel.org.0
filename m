Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECEA6D7246
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 04:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjDECJC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 22:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDECJB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 22:09:01 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com (sonic305-9.consmr.mail.bf2.yahoo.com [74.6.133.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6783ABC
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 19:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680660538; bh=POUiPiHx5Op8Co+/7C1zE+TI6wGNYFHsxVEQ4fAhoWU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=M1jJhD0k9wGfrpoeX4UvsDlv5hwlvJDgxGxVIwz5DCMMnD3mDdn8qYGfeMG1wQL6OcgU1epsFWnpyUUq96BE/OuzI1meg0Gmydj/bFYroVGGiwoDdFoy8u7H8VEL3EBITNt8/KB/R/+WcqtRXWozD7HExcP5rf9oaiQTxuqfJ1Pmlm2WQQZr00GVPhdIZ/Q8L4HslqkBvaIeT6nXblIKPpdwvmVgvuqUvRjH7h7S4Sw9887UZ/ZAxyMOw6WZkDXFw9Zj4Jf7fInmCzYNAvWB3qtU+OYw5AHkKeuls/Hjs+6Q/9yekPEuA2e4cZl0UJoD+GeTPUPi4fpKhqYwE/2Z/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680660538; bh=5zJ0WYvaBW+acISnlpuXFlfRSQbBctHGSF3oNtUzH3p=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ec1phjysvXy1NTPVkHUeZaV4qxMu6lYqqNFF33QXN91bkiuUW+Et86FrEbdj8S1Sx68XExUzSp6+8mKR4AyUzZAWExfVyVywHgnURS1CdvHA/WrdliGuZNYBr7LQIH4X5hfeTTcqYwdgJL+AOsYGwCI8mto7/TUihJN+AIj4BrOmopz2a4eytn4cncuyZdhxCzLlt8N/sOpP2KWjnPRJueCv8R717ZxfAigqEvZZtqt54tEqMnBXX4eohT9ewLQ3fJ41LSIQq+ZYMvbkQw2ZVu7PIkSKvyMPKQcpUCfzC86RfAYEhHp/mKp0cvCvOWhu+BOT58yVEYNaAa3Hoddohw==
X-YMail-OSG: mXgVUUIVM1l76S3yuMSTgJD48snBRYLETvmbAQ2sVZKJ9i8r11CLTUtwlUJfHml
 _6eZTtmWKzQVtMhMAW0O8Ap.U33oMdgaR18pQGv7UUG2sD1Gf.wEilQFVn1z4y8szkvTsyaFILKo
 8pmZ1hCGwH5EzJDPYCV5pzOuHBy0OHbJkxwsWr2olv03Wu0cZDHCYLFB9W2wDEgqVRYkq4avROy9
 _tLAVrIPsE1hhO2qxG.4oYTE6WTJ0P2MBT3E7UcVXX.D7sFf04_XL5ckt3DSn5_914Xuuio2tigP
 J3rxW701GOG_IQMWe3yx7UmXbdd3WskfLFTUJIy1pSZ546C9W8sPL3foUABOp8X2o85Dd0TT7lWi
 LGZDjjKgeV_RbiRIwfGj_xPhvGA8tZF7hyVSB3Xx0mfBL4qkU4hSPMiN3V66icul3kVDCSUDoChL
 PjURZdcHcm.fPEB5IFTeLE9INCuyxl8kOdVDmt_F7D4RWFB8uE28Q7ZwK3lPM.TdlcQzaJRUTjVg
 PyOjlu30FK1tef9ORxuE8JUV33WTJhBcH16W8OsmTbpal31_Ed780Oge5Eg0KajSaNvnRkBAkpUe
 gC5eZUGDSS7DCTa027BFf6VnDWvYATCpm6zmso8rXjnMjj71W_o1FR3LeI8MVjfXGqZ_ZHtKcp1i
 TLxdsBQYaWdwTCZyB6HwCUIZMWFKwRbipRsUn29ZAJaw1U5ARI9nIkWQzNvaFl4CvKeq4.Dhuat0
 OZTt.mzJPvKMyVUsABhEu_vX8xV8jDmaD4XByjRQXJN4sejasfZ4e_aM9xpsN4XFkV3VhuD.z9Xx
 xQporFk4jMSGk2IxWU5u5wBqWkw9cHB5X46tkfWuCX9tN.hcx9LrAHi3ZUpuf3IlH8rQVQLHxhb9
 QPZph4oxTa3Yw3AJZG.80RXeXBcGySsdVgoN0YWDmo.U9TjmmP65ghWHagyi1vE56mLwLPGkhy_.
 uLwnfg5hbFc3Psfy3_lJMfiP6l.WqTrEu78oQB_1st.jjs3TrDcR03u0SSibTg.SUjnDILAcDmb3
 cg.Ol77QwIqggub0KV1zgZNHkr9gXsBpx4H_1Rle.6ts.QQMuT2s_rc.39tQ4uQ81UcsrrgFvw4u
 Dkgz1b9vde4HO0yUbogRgXZ6EGbX_rdaXWjIBIFl_ZP4T_IN0WX8XsDTSB2oivqbXhBWEQiDWn_I
 1ZSz7VGLObXNxynW5Cj09SBdAxtq1fAnRdG5QlJQalJ0HClLVLZdcrhJNo0xPUy0QT1EB70EIywS
 Lfl8fg9QLX5Ye4cx3kV97XAn2jvY2Tav9opHQ.1p5BQrYC1mraH_W_8D.XMpNRV2N07JDdbw3yyR
 35McfP1KWIEjuQe5.tEd9m4nFlCLyUCxo2n7GMj0dyavmepF06s1jQsackRlslupS0oCAdTmb_CY
 WnvsBRWPBYBIFfHR9AY1TYgIN7GdV5WVLXXIO7lLlfJxqrnwtnEouPSFW1SeWfkfc5AhPDG2SksT
 XwU5u872t_FjoRSU7iaLDJzJ982zWf25Wemk5N1BGyoLwd1KkSZXfiSJszZNyrzO8S36LTuIPia4
 qET2SHLXTs9YIQ32AWo53khCJ5JTQ.WJe_PnCx2IvmW6JB2obOtAVeL6LGs_RMtAP0d.QGq8r_yg
 lNskckrik_ZtdDLszWgHJcJfYFRaY3Sa2p9S997Itg3jLDsfZO5a1dLswhNUhSZkZEco_Gafat.U
 qDENKemyGTSk5h77CGOr3F9KETkUjW2TslITyrYhwf4uqu254GoNdhw1EbiPVnk4.1JGa2FKQ0sZ
 PDqeHI_xIXMOVwaxRt8mVAUgWs2RLZ2.gdVSb_8R1nl2Hz86JFtmJYESGtSLXYssbyZMwzevtwc3
 0pPkgxVFCVo.tyALtu0VLo_RjLsHLnUDiQGrnk4fyNmobNihwx2eFgHvVm9XcXF.tHK8kdtDd4BZ
 dWNYe5QLuk8_Wu7QQxCklP3YVoXBfvrT4Dek7Ml2vA2WficoEO.8.xYZsVUgiHUVPn1ktVNFIdVS
 k0.eGwrFF7FmvJ_wFK93Pez5gaUUvc9NXOIvcb2OlGrfD9T8ywOcRxI6aVaBwIfPKvhKY909dnk_
 wr84o5vQX1H8jw_DL7Xrllx0E495kjkdJVRXwNUgmUXTvZkxiY.94Q3yjKF2X6yohTEbQirCuYCA
 tgfAvVFmP9CHk.3tlf4IPtrNbKUU7OZE.8vv9cWUS3ZlwkrvMfYuct2nLYc_JUlIMIehlutf2mTS
 .pqx9.YABB.4NUyALXs_YjB2HzJ91c_fPTl5cmLIWOCxNTAV2qQa6wVou5hcwI.kI0lmDeYNDChN
 8Yn2ajd_9FtZNag--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c8cc01b1-f45c-4585-8135-424cbd90d501
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Wed, 5 Apr 2023 02:08:58 +0000
Received: by hermes--production-ne1-7dbd98dd99-jck6p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c5eaed2b94a82be2cf8940161b3cfa58;
          Wed, 05 Apr 2023 02:08:53 +0000 (UTC)
Message-ID: <5dbb9430-1e26-ec12-26a2-3718c84e33c2@schaufler-ca.com>
Date:   Tue, 4 Apr 2023 19:08:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Paul Moore <paul@paul-moore.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
 <20230331123221.3273328-3-roberto.sassu@huaweicloud.com>
 <CAHC9VhSbGdij6xz9D49my37kD9qYrBmh2x7=cNFFDL2dZ=EZTw@mail.gmail.com>
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSbGdij6xz9D49my37kD9qYrBmh2x7=cNFFDL2dZ=EZTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/4/2023 11:54 AM, Paul Moore wrote:
> On Fri, Mar 31, 2023 at 8:33 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Currently, security_inode_init_security() supports only one LSM providing
>> an xattr and EVM calculating the HMAC on that xattr, plus other inode
>> metadata.
>>
>> Allow all LSMs to provide one or multiple xattrs, by extending the security
>> blob reservation mechanism. Introduce the new lbs_xattr_count field of the
>> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
>> needs, and the LSM infrastructure knows how many xattr slots it should
>> allocate.
>>
>> Dynamically allocate the new_xattrs array to be populated by LSMs with the
>> inode_init_security hook, and pass it to the latter instead of the
>> name/value/len triple. Unify the !initxattrs and initxattrs case, simply
>> don't allocate the new_xattrs array in the former.
>>
>> Also, pass to the hook the number of xattrs filled by each LSM, so that
>> there are no gaps when the next LSM fills the array. Gaps might occur
>> because an LSM can legitimately request xattrs to the LSM infrastructure,
>> but not fill the reserved slots, if it was not initialized.
>>
>> Update the documentation of security_inode_init_security() to reflect the
>> changes, and fix the description of the xattr name, as it is not allocated
>> anymore.
>>
>> Finally, adapt both SELinux and Smack to use the new definition of the
>> inode_init_security hook, and to fill the reserved slots in the xattr
>> array. Introduce the lsm_get_xattr_slot() helper to retrieve an available
>> slot to fill, and to increment the number of filled slots.
>>
>> Move the xattr->name assignment after the xattr->value one, so that it is
>> done only in case of successful memory allocation. For Smack, also reserve
>> space for the other defined xattrs although they are not set yet in
>> smack_inode_init_security().
>>
>> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash)
>> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>  include/linux/lsm_hook_defs.h |  6 +--
>>  include/linux/lsm_hooks.h     | 20 ++++++++++
>>  security/security.c           | 71 +++++++++++++++++++++++------------
>>  security/selinux/hooks.c      | 17 +++++----
>>  security/smack/smack_lsm.c    | 32 ++++++++++------
>>  5 files changed, 99 insertions(+), 47 deletions(-)
> This looks good aside from a few small things (below).  From what I
> can see, there are only two outstanding issues to answer: the number
> of Smack xattrs, sign-off from Casey for the Smack bits.
>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 6bb55e61e8e..a1896f90089 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -111,9 +111,9 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
>>          unsigned int obj_type)
>>  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
>> -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
>> -        struct inode *dir, const struct qstr *qstr, const char **name,
>> -        void **value, size_t *len)
>> +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
>> +        struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
>> +        int *xattr_count)
>>  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>>          const struct qstr *name, const struct inode *context_inode)
>>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index c2be66c669a..9eb9b686493 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -28,6 +28,7 @@
>>  #include <linux/security.h>
>>  #include <linux/init.h>
>>  #include <linux/rculist.h>
>> +#include <linux/xattr.h>
>>
>>  union security_list_options {
>>         #define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
>> @@ -63,8 +64,27 @@ struct lsm_blob_sizes {
>>         int     lbs_ipc;
>>         int     lbs_msg_msg;
>>         int     lbs_task;
>> +       int     lbs_xattr_count; /* number of xattr slots in new_xattrs array */
>>  };
>>
>> +/**
>> + * lsm_get_xattr_slot - Return the next available slot and increment the index
>> + * @xattrs: array storing LSM-provided xattrs
>> + * @xattr_count: number of already stored xattrs (updated)
>> + *
>> + * Retrieve the first available slot in the @xattrs array to fill with an xattr,
>> + * and increment @xattr_count.
>> + *
>> + * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
>> + */
>> +static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>> +                                              int *xattr_count)
>> +{
>> +       if (unlikely(!xattrs))
>> +               return NULL;
>> +       return xattrs + (*xattr_count)++;
>> +}
>> +
>>  /*
>>   * LSM_RET_VOID is used as the default value in LSM_HOOK definitions for void
>>   * LSM hooks (in include/linux/lsm_hook_defs.h).
>> diff --git a/security/security.c b/security/security.c
>> index f4170efcddd..1aeaa8ce449 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -31,8 +31,6 @@
>>  #include <linux/msg.h>
>>  #include <net/flow.h>
>>
>> -#define MAX_LSM_EVM_XATTR      2
>> -
>>  /* How many LSMs were built into the kernel? */
>>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>>
>> @@ -212,6 +210,8 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>>         lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
>>         lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>>         lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
>> +       lsm_set_blob_size(&needed->lbs_xattr_count,
>> +                         &blob_sizes.lbs_xattr_count);
>>  }
>>
>>  /* Prepare LSM for initialization. */
>> @@ -378,6 +378,7 @@ static void __init ordered_lsm_init(void)
>>         init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
>>         init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>>         init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>> +       init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
>>
>>         /*
>>          * Create any kmem_caches needed for blobs
>> @@ -1591,11 +1592,15 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
>>   * created inode and set up the incore security field for the new inode.  This
>>   * hook is called by the fs code as part of the inode creation transaction and
>>   * provides for atomic labeling of the inode, unlike the post_create/mkdir/...
>> - * hooks called by the VFS.  The hook function is expected to allocate the name
>> - * and value via kmalloc, with the caller being responsible for calling kfree
>> - * after using them.  If the security module does not use security attributes
>> - * or does not wish to put a security attribute on this particular inode, then
>> - * it should return -EOPNOTSUPP to skip this processing.
>> + * hooks called by the VFS.  The hook function is expected to populate the
>> + * @xattrs array, by calling lsm_get_xattr_slot() to retrieve the slots
>> + * reserved by the security module with the lbs_xattr_count field of the
>> + * lsm_blob_sizes structure.  For each slot, the hook function should set ->name
>> + * to the attribute name suffix (e.g. selinux), to allocate ->value (will be
>> + * freed by the caller) and set it to the attribute value, to set ->value_len to
>> + * the length of the value.  If the security module does not use security
>> + * attributes or does not wish to put a security attribute on this particular
>> + * inode, then it should return -EOPNOTSUPP to skip this processing.
>>   *
>>   * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute is
>>   * needed, or -ENOMEM on memory allocation failure.
>> @@ -1604,33 +1609,51 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>>                                  const struct qstr *qstr,
>>                                  const initxattrs initxattrs, void *fs_data)
>>  {
>> -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
>> -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
>> -       int ret;
>> +       struct security_hook_list *P;
>> +       struct xattr *new_xattrs = NULL;
>> +       int ret = -EOPNOTSUPP, xattr_count = 0;
>>
>>         if (unlikely(IS_PRIVATE(inode)))
>>                 return 0;
>>
>> -       if (!initxattrs)
>> -               return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
>> -                                    dir, qstr, NULL, NULL, NULL);
>> -       memset(new_xattrs, 0, sizeof(new_xattrs));
>> -       lsm_xattr = new_xattrs;
>> -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
>> -                           &lsm_xattr->name,
>> -                           &lsm_xattr->value,
>> -                           &lsm_xattr->value_len);
>> -       if (ret)
>> +       if (!blob_sizes.lbs_xattr_count)
>> +               return 0;
>> +
>> +       if (initxattrs) {
>> +               /* Allocate +1 for EVM and +1 as terminator. */
>> +               new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 2,
>> +                                    sizeof(*new_xattrs), GFP_NOFS);
>> +               if (!new_xattrs)
>> +                       return -ENOMEM;
>> +       }
>> +
>> +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
>> +                            list) {
>> +               ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs,
>> +                                                 &xattr_count);
>> +               if (ret && ret != -EOPNOTSUPP)
>> +                       goto out;
>> +               /*
>> +                * As documented in lsm_hooks.h, -EOPNOTSUPP in this context
>> +                * means that the LSM is not willing to provide an xattr, not
>> +                * that it wants to signal an error. Thus, continue to invoke
>> +                * the remaining LSMs.
>> +                */
>> +       }
>> +
>> +       /* If initxattrs() is NULL, xattr_count is zero, skip the call. */
>> +       if (!xattr_count)
>>                 goto out;
>>
>> -       evm_xattr = lsm_xattr + 1;
>> -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
>> +       ret = evm_inode_init_security(inode, new_xattrs,
>> +                                     new_xattrs + xattr_count);
> I think it's cleaner to write '&new_xattrs[xattr_count]' for the third
> parameter above (no concerns around pointer math), and stylistically
> it matches better with the for-kfree loop below.
>
>>         if (ret)
>>                 goto out;
>>         ret = initxattrs(inode, new_xattrs, fs_data);
>>  out:
>> -       for (xattr = new_xattrs; xattr->value != NULL; xattr++)
>> -               kfree(xattr->value);
>> +       for (; xattr_count > 0; xattr_count--)
>> +               kfree(new_xattrs[xattr_count - 1].value);
>> +       kfree(new_xattrs);
>>         return (ret == -EOPNOTSUPP) ? 0 : ret;
>>  }
>>  EXPORT_SYMBOL(security_inode_init_security);
> ..
>
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index cfcbb748da2..8392983334b 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -52,6 +52,15 @@
>>  #define SMK_RECEIVING  1
>>  #define SMK_SENDING    2
>>
>> +/*
>> + * Smack uses multiple xattrs.
>> + * SMACK64 - for access control, SMACK64EXEC - label for the program,
> I think it would be good to move SMACK64EXEC to its own line; it took
> me a minute to figure out why SMACK_INODE_INIT_XATTRS was set to '4'
> when I only say three comment lines ... ;)
>
>> + * SMACK64MMAP - controls library loading,
>> + * SMACK64TRANSMUTE - label initialization,
>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>> + */
>> +#define SMACK_INODE_INIT_XATTRS 4
> If smack_inode_init_security() only ever populates a single xattr, and
> that is the only current user of SMACK_INODE_INIT_XATTRS, can we make
> this '1' and shrink the xattr allocation a bit?

If the parent directory is marked with SMACK64_TRANSMUTE, the access
rule allowing the access has the "t" mode, and the object being initialized
is a directory, the new inode should get the SMACK64_TRANSMUTE attribute.
The callers of security_inode_init_security() don't seem to care.
I can't say if the evm code is getting SMACK64_TRANSMUTE or, for that
matter, SMACK64_EXEC and SMACK64_MMAP, some other way. The older system
allowed for multiple Smack xattrs, but I'm not clear on exactly how.


>>  #ifdef SMACK_IPV6_PORT_LABELING
>>  static DEFINE_MUTEX(smack_ipv6_lock);
>>  static LIST_HEAD(smk_ipv6_port_list);
>> @@ -939,26 +948,23 @@ static int smack_inode_alloc_security(struct inode *inode)
>>   * @inode: the newly created inode
>>   * @dir: containing directory object
>>   * @qstr: unused
>> - * @name: where to put the attribute name
>> - * @value: where to put the attribute value
>> - * @len: where to put the length of the attribute
>> + * @xattrs: where to put the attributes
>> + * @xattr_count: current number of LSM-provided xattrs (updated)
>>   *
>>   * Returns 0 if it all works out, -ENOMEM if there's no memory
>>   */
>>  static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>> -                                    const struct qstr *qstr, const char **name,
>> -                                    void **value, size_t *len)
>> +                                    const struct qstr *qstr,
>> +                                    struct xattr *xattrs, int *xattr_count)
>>  {
>>         struct inode_smack *issp = smack_inode(inode);
>>         struct smack_known *skp = smk_of_current();
>>         struct smack_known *isp = smk_of_inode(inode);
>>         struct smack_known *dsp = smk_of_inode(dir);
>> +       struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>>         int may;
>>
>> -       if (name)
>> -               *name = XATTR_SMACK_SUFFIX;
>> -
>> -       if (value && len) {
>> +       if (xattr) {
>>                 rcu_read_lock();
>>                 may = smk_access_entry(skp->smk_known, dsp->smk_known,
>>                                        &skp->smk_rules);
>> @@ -976,11 +982,12 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>                         issp->smk_flags |= SMK_INODE_CHANGED;
>>                 }
>>
>> -               *value = kstrdup(isp->smk_known, GFP_NOFS);
>> -               if (*value == NULL)
>> +               xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
>> +               if (xattr->value == NULL)
>>                         return -ENOMEM;
>>
>> -               *len = strlen(isp->smk_known);
>> +               xattr->value_len = strlen(isp->smk_known);
>> +               xattr->name = XATTR_SMACK_SUFFIX;
>>         }
>>
>>         return 0;
>> @@ -4854,6 +4861,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>>         .lbs_ipc = sizeof(struct smack_known *),
>>         .lbs_msg_msg = sizeof(struct smack_known *),
>>         .lbs_superblock = sizeof(struct superblock_smack),
>> +       .lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
>>  };
>>
>>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>> --
>> 2.25.1
