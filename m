Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78B6D12CA
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 01:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjC3XF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 19:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjC3XF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 19:05:58 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB87FF3A
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680217555; bh=JMS446UlVeOxPRi+0JzdYg22Z71t5DNNBvdM9U11yIQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=aEY3OJwzNdcibfvrrSznjmfhQIR9TJ7h+ifteIJlzSOQCRZSItIT+hu4TsDqQRXC2sv3EttJOwGLWyx99Rb7F8+NbmDlxZh/a4EXLQXLBAk48F0OtUeImKEhasWkU5BVJpk+jMlSUARZfwjF4YI/rrupJJ+tktNJp9pfUgdm54SEdvHWPU8prIqKyfecHPdfhC4qurJ8+CAoaeBTLXBA5piUW9dQQZap6zvutzb3RnjyoZdtU91tftCDJu2VMTJYRlgPedRwtHX9byQn6zbeXds0LMhuXr039Zl6hpD191mNHMTGfZARY/0dyQCi2LZTNnlrPuuSKZto/gR2MVzDjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680217555; bh=EFtgBDqRqCeqpjxwzkcQ+6DPBZmuDSOCGoO74wjh0bC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AuW7cZkkHAnUqYggyiiKgvdI8M5Le0jlDzyFmYNnTSwspOeNy6rUKM+Kz2tLm+CoKrrHVDF8LpCU2t1KsVWZEiOesddEAlaYs5Mngr0GqfyLqbaLrMvErDvAwxNXsgi0YXX7e0X13yhgKE7WLunVtWtPzEuwgLCiI+5ziz1qWHVBaqoNv0VLBgztesCnipK4Tihf9xxZp6HyA962on+iO+VpjAaTQ2CeRwbx8AnynpVoRYs3EesbDBmmBrBu045k0UrNIp+OAbw42dPfVgPJ592JJUiw7FuPOpAsxcc71I6RU1XI4jOvJXMXimnZEQIWEzJreBKX6DvjBBrrhjYEaw==
X-YMail-OSG: UBkh9A0VM1lga_GntYf6Zv4CKzsq5k6Bq6gn1fHC5TXL3k46hINXbVwbDsBB1N9
 _5ELRnc.YJ2DecbERg_zEDK5LCZBUC3ywKa8Pv7Yvd_HWQ77Tf2oBdsXmPsc4Gjy.B0Cw0zmkTiV
 Uw7WLhDYgAm1OBAVXfJ0_Am5VMLDkACFL5r7O_2KaaHAPAGEmz18QSfiSCtYCOe6p3Tvm3P7lboG
 FSyg5c.G19nOexPD4Pyq6a7Dn_J1MYUlgCS_PG9i918lUqsvAQgGXnxZM5CU_yWYVBcjt8I7WsV9
 CC3cdOC.VCBkXDmMaSnUO8hC8MB6owtYQZMbxzsAqTJO6j_epVYFQk4I57FZooQprTbmr6Dhnady
 KKyvonOd5Ts9cW.ni0CjmthO9_wHw.5eVkTwWmCAcODeBIStVobgz6IpuFOl336P0X5ufrar5ocu
 HMk3XAspVMpNMbbdHgMhdPNfFsZYqFInIrcPfjFZnJf9gDL8fw07QRJUbp4jxgA7OxpuCwQa1dSY
 4YWIpVFPBbOSyoI8wX67B1GOmIh.UBWOGJvOe1465QBweNbbKc.uAc0IRi7GC3qrs085z4KTGFoK
 0BEsszZXuLqUPoKRJ5toB790yNS3W_MgxbgwElmLBCpK2KINfBwRqqD3L7QrD2EtsYKpq6NziNqO
 vChR_yu1XmE2Z60L8fO68ViOD5eDZsFqKkZ80kDPs2fb05KYyG5cZJPRcY5HJMixtlQUJwNqsm5q
 kYGYXi8nZfpAK5C4gw5gxQKK0T_6PEFnyNLIxtpLDJdIz_WimIJXaefjDcG_munriXRwM1DCx256
 rQx9ob3HhORvpicykt.oER9fFy6xTKqzV5prP5MF2vm101iZm16UM_Wb7afHarvj_wcD4OHtIPBp
 m3mSWy69gFI9gGa_krZvLdfysw3NmF7uLpUryypzSoxlCTSVAmi9.yXmZfDU4.L1puaulySCMsIr
 4cNiwCF6vRjvZ7D7XILGGq8rScpe_sPHiifTRaOZHZqqnDQFZkon6EERIVl1fODW4Tdi5yB40mig
 Xv8GFJeB6TzJIr4b5dzt9oyN7.2qISci34ApnnJwlnpg2a3aax4TVi6PDT9fxm9ha4SuSb5Z4fVO
 yOmuQcGsmrVh9iNKB2gnK66Vt5g.48IaRuAdDooDA5UHVSObcOju8RoEtbynGzwp3yaOtCm8xMbd
 fSa5LnU47t6VI6LtTF7NCNb_iMD9Y_f8RrYVX5RdmwDdWCUbssFXIo5Z2EDlnYzHsrzn6pdWES5J
 0ZSCRqa7o5f8uqOZrnUOXzBYPxh7i5f_9UiaU9RHY9vDQWd06br9XGdxm.vBKey6X5su7J5nxLm7
 1J3h.UpnstOVGCLHSsnxDDjtthx0KG1aYDIE4_AejbKuuzPzjP1dosRxZcvKPybqzWfX5aQ4l2XJ
 Z9cu5oizTNIOV5dDm_7HEtBwe_CbRb8s.H69wwRwweNRUEy5_riV9FL5mQRxmA26Mc3NWfbye75E
 kys73McQkDStiwsritMn3IO3szlNAGd1gr6RrCuV6FytxcrW.._m8S9144frw8Gb2pTcHnLMhTOJ
 W1uLD9rlZ8uDpjjgdr5UhxSYFIhMYWSLLR6VS07DEjurhdBxRdwnGyhAgHoZy.306ZKwkZiYOe13
 .tCm1o1cqo9OUmwa0SpUaEk3eak4Pik_U6JJQIn0gjhHsfrKlJyXSU96d3xmRCjGgNhgMBoNhrDX
 nZ3hDUDH8u1zpHocvLfpOHxoTVbdZzj4mDBYN3OwlHhse8m07gtGrZuCawE.2KhtkKDPMzg0Xiaj
 eJ06t4gEmrwBuhDnoaCJlhOCyRiDWXruVWTXlzHSD7VvaktYsbohDG0zYVdukdelAME32dB3QY2U
 cpbPq4lBiOaS7rhE6le30eW3Z8kn9YOQ3qoiQE20EKPoe5zLzIshn.DwC6SUTFMIxKEfmZp5JoUX
 z94bMKdGZpDXBQe9SVXZilNYgQN3C34UP227Ev4nfiBijFeTMrOf804BSji8ZcHji56ougpKYd8c
 4Jv6eFSgVAaIlwjmaUL1JjQJQMvpz1AAO1lisPaeLIbzG17_bTISnJbQyw6Hu4ceZTF7fkffoihf
 EppWDRygbQ_HnqzjBxNG2wIrGpmLqU90S3iz.29UoLRuWL80veyMo7v7B0CodCzsZDO3ESCPGXLP
 hmpo1ozm2v1aSyd4sPAvO800N1jdBkOjVRc7JUoqJNv4mduaC3irm3tP2aWLA2sJ_mREnsHqZp7E
 BE8XwNxSAkQkiPTKEz.yzJNdhGdzYCI8cJwGdbXKImTcRxbSixmyxHO5eV203JqEDiem0RVdPWoD
 MJyien5Cxnw72_AYu2ec-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 872718af-2236-4a65-8853-942ee8388559
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Mar 2023 23:05:55 +0000
Received: by hermes--production-bf1-5f9df5c5c4-bqwvr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d4d83185362b7f1ecbcc0636ddd9dc6;
          Thu, 30 Mar 2023 23:05:51 +0000 (UTC)
Message-ID: <7100a49a-49db-6e78-2b37-26193c82354b@schaufler-ca.com>
Date:   Thu, 30 Mar 2023 16:05:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
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
References: <20230329130415.2312521-1-roberto.sassu@huaweicloud.com>
 <20230329130415.2312521-3-roberto.sassu@huaweicloud.com>
 <CAHC9VhTTcejig61X1Qf_rXWzjyz8HNLNg=KqExRqDH7+McChkw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTTcejig61X1Qf_rXWzjyz8HNLNg=KqExRqDH7+McChkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/2023 3:50 PM, Paul Moore wrote:
> On Wed, Mar 29, 2023 at 9:05 AM Roberto Sassu
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
>> name/value/len triple.
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
>> On the security_inode_init_security() side, ensure that if LSMs returned
>> zero from the hook, they correctly filled a new_xattrs slot. Consequently,
>> change the default return value of the hook to -EOPNOTSUPP, so that BPF LSM
>> returns that, and does not cause security_inode_init_security() to fail.
>>
>> Finally, adapt both SELinux and Smack to use the new definition of the
>> inode_init_security hook, and to fill the reserved slots in the xattr
>> array. Introduce the lsm_find_xattr_slot() helper to retrieve an available
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
>>  include/linux/lsm_hooks.h     | 14 ++++++
>>  security/security.c           | 92 +++++++++++++++++++++++++++--------
>>  security/selinux/hooks.c      | 18 ++++---
>>  security/smack/smack_lsm.c    | 33 ++++++++-----
>>  5 files changed, 120 insertions(+), 43 deletions(-)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 6bb55e61e8e..1fd95db0087 100644
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
>> +        int *num_filled_xattrs)
>>  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>>          const struct qstr *name, const struct inode *context_inode)
>>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index c2be66c669a..b60de5f2f34 100644
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
>> @@ -63,8 +64,21 @@ struct lsm_blob_sizes {
>>         int     lbs_ipc;
>>         int     lbs_msg_msg;
>>         int     lbs_task;
>> +       int     lbs_xattr_count; /* number of xattr slots in new_xattrs array */
>>  };
>>
>> +/*
>> + * Retrieve the first available slot to fill with an xattr, and increment
>> + * the number of filled slots.
>> + */
>> +static inline struct xattr *lsm_find_xattr_slot(struct xattr *xattrs,
>> +                                               int *num_filled_xattrs)
>> +{
>> +       if (unlikely(!xattrs))
>> +               return NULL;
>> +       return xattrs + (*num_filled_xattrs)++;
>> +}
> Since this function increments the @num_filled_xattrs parameter in
> addition to returning the next available xattr array slot, let's
> replace the "find" with "get" so there is some hint that the state is
> changing, i.e. the count is being bumped (similar to the "get" and
> "put" concept).
>
> It would also be nice if you could use the kdoc style for the function
> comment block; if nothing else it is a known format and consistent
> documentation is good, even if it never makes it out of the source
> file.
>
>>  /*
>>   * LSM_RET_VOID is used as the default value in LSM_HOOK definitions for void
>>   * LSM hooks (in include/linux/lsm_hook_defs.h).
>> diff --git a/security/security.c b/security/security.c
>> index f4170efcddd..be33d643a81 100644
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
>> + * @xattrs array, by calling lsm_find_xattr_slot() to retrieve the slots
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
>> @@ -1604,33 +1609,80 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>>                                  const struct qstr *qstr,
>>                                  const initxattrs initxattrs, void *fs_data)
>>  {
>> -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
>> -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
>> -       int ret;
>> +       struct security_hook_list *P;
>> +       struct xattr *new_xattrs;
>> +       struct xattr *xattr;
>> +       int num_filled_xattrs = 0, old_num_filled_xattrs;
> I think you can get rid of @old_num_filled_xattrs (see below), but how
> about changing @num_filled_xattrs to @xattr_count, it's shorter and
> just as accurate.
>
>> +       int ret = -EOPNOTSUPP, i;
>>
>>         if (unlikely(IS_PRIVATE(inode)))
>>                 return 0;
>>
>> +       if (!blob_sizes.lbs_xattr_count)
>> +               return 0;
>> +
>>         if (!initxattrs)
>>                 return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
>> -                                    dir, qstr, NULL, NULL, NULL);
> I would have expected the !initxattrs case to still be handled in the
> hook loop below, is there a reason why we don't want to do that?  If
> including it in the loop below is too much of a hassle (conditional
> array allocation, etc.), should we at least put it in it's own loop?
> It seems wrong that we wouldn't run through all of the LSM hooks in
> this case ...
>
>> -       memset(new_xattrs, 0, sizeof(new_xattrs));
>> -       lsm_xattr = new_xattrs;
>> -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
>> -                           &lsm_xattr->name,
>> -                           &lsm_xattr->value,
>> -                           &lsm_xattr->value_len);
>> -       if (ret)
>> +                                   dir, qstr, NULL, NULL);
>> +       /* Allocate +1 for EVM and +1 as terminator. */
>> +       new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 2,
>> +                            sizeof(*new_xattrs), GFP_NOFS);
>> +       if (!new_xattrs)
>> +               return -ENOMEM;
>> +
>> +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
>> +                            list) {
>> +               old_num_filled_xattrs = num_filled_xattrs;
>> +
>> +               ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs,
>> +                                                 &num_filled_xattrs);
>> +               if (ret && ret != -EOPNOTSUPP)
>> +                       goto out;
>> +               /*
>> +                * As documented in lsm_hooks.h, -EOPNOTSUPP in this context
>> +                * means that the LSM is not willing to provide an xattr, not
>> +                * that it wants to signal an error. Thus, continue to invoke
>> +                * the remaining LSMs.
>> +                */
>> +               if (ret == -EOPNOTSUPP)
>> +                       continue;
>> +
>> +               /* LSM should fill new_xattrs if it returns zero. */
>> +               if (old_num_filled_xattrs == num_filled_xattrs) {
>> +                       WARN_ONCE(1, "LSM %s: returned zero but didn't fill any slot\n",
>> +                                 P->lsm);
>> +                       ret = -EINVAL;
>> +                       goto out;
>> +               }
> Do we really need this check?  We don't currently check that LSMs
> setup their xattrs properly and we are doing okay.
>
>> +               /*
>> +                * For filled xattr slots, name and value must be non-NULL.
>> +                *
>> +                * NULL value is interpreted by filesystems as a remove op, see
>> +                * ext4_xattr_set_handle() for more details.
>> +                */
>> +               for (i = old_num_filled_xattrs; i < num_filled_xattrs; i++) {
>> +                       if (!new_xattrs[i].name || !new_xattrs[i].value) {
>> +                               WARN_ONCE(1, "LSM %s: NULL xattr name and/or value\n",
>> +                                         P->lsm);
>> +                               ret = -EINVAL;
>> +                               goto out;
>> +                       }
>> +               }
> Same here.  I worry this is extra processing with little benefit.  The
> LSM updates the xattr count and we should trust it is correct.
>
>> +       }
>> +
>> +       if (!num_filled_xattrs)
>>                 goto out;
>>
>> -       evm_xattr = lsm_xattr + 1;
>> -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
>> +       ret = evm_inode_init_security(inode, new_xattrs,
>> +                                     new_xattrs + num_filled_xattrs);
>>         if (ret)
>>                 goto out;
>>         ret = initxattrs(inode, new_xattrs, fs_data);
>>  out:
>>         for (xattr = new_xattrs; xattr->value != NULL; xattr++)
>>                 kfree(xattr->value);
> We can probably drop the need for the @xattr variable by using @xattr_count.
>
>   for (; xattr_count > 0; xattr_count--)
>     kfree(new_xattrs[xattr_count - 1]->value);
>
>> +       kfree(new_xattrs);
>>         return (ret == -EOPNOTSUPP) ? 0 : ret;
>>  }
>>  EXPORT_SYMBOL(security_inode_init_security);
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 9a5bdfc2131..dc349cf34e8 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -104,6 +104,8 @@
>>  #include "audit.h"
>>  #include "avc_ss.h"
>>
>> +#define SELINUX_INODE_INIT_XATTRS 1
>> +
>>  struct selinux_state selinux_state;
>>
>>  /* SECMARK reference count */
>> @@ -2868,11 +2870,12 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
>>
>>  static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>>                                        const struct qstr *qstr,
>> -                                      const char **name,
>> -                                      void **value, size_t *len)
>> +                                      struct xattr *xattrs,
>> +                                      int *num_filled_xattrs)
> Use 'xattr_count'.
>
>>  {
>>         const struct task_security_struct *tsec = selinux_cred(current_cred());
>>         struct superblock_security_struct *sbsec;
>> +       struct xattr *xattr = lsm_find_xattr_slot(xattrs, num_filled_xattrs);
>>         u32 newsid, clen;
>>         int rc;
>>         char *context;
>> @@ -2899,16 +2902,14 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>>             !(sbsec->flags & SBLABEL_MNT))
>>                 return -EOPNOTSUPP;
>>
>> -       if (name)
>> -               *name = XATTR_SELINUX_SUFFIX;
>> -
>> -       if (value && len) {
>> +       if (xattr) {
>>                 rc = security_sid_to_context_force(&selinux_state, newsid,
>>                                                    &context, &clen);
>>                 if (rc)
>>                         return rc;
>> -               *value = context;
>> -               *len = clen;
>> +               xattr->value = context;
>> +               xattr->value_len = clen;
>> +               xattr->name = XATTR_SELINUX_SUFFIX;
>>         }
>>
>>         return 0;
>> @@ -6918,6 +6919,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>>         .lbs_ipc = sizeof(struct ipc_security_struct),
>>         .lbs_msg_msg = sizeof(struct msg_security_struct),
>>         .lbs_superblock = sizeof(struct superblock_security_struct),
>> +       .lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
>>  };
>>
>>  #ifdef CONFIG_PERF_EVENTS
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index cfcbb748da2..ba10f4e8632 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -52,6 +52,15 @@
>>  #define SMK_RECEIVING  1
>>  #define SMK_SENDING    2
>>
>> +/*
>> + * Smack uses multiple xattrs.
>> + * SMACK64 - for access control, SMACK64EXEC - label for the program,
>> + * SMACK64MMAP - controls library loading,
>> + * SMACK64TRANSMUTE - label initialization,
>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>> + */
>> +#define SMACK_INODE_INIT_XATTRS 4
>> +
>>  #ifdef SMACK_IPV6_PORT_LABELING
>>  static DEFINE_MUTEX(smack_ipv6_lock);
>>  static LIST_HEAD(smk_ipv6_port_list);
>> @@ -939,26 +948,24 @@ static int smack_inode_alloc_security(struct inode *inode)
>>   * @inode: the newly created inode
>>   * @dir: containing directory object
>>   * @qstr: unused
>> - * @name: where to put the attribute name
>> - * @value: where to put the attribute value
>> - * @len: where to put the length of the attribute
>> + * @xattrs: where to put the attributes
>> + * @num_filled_xattrs: current number of filled xattrs (updated)
>>   *
>>   * Returns 0 if it all works out, -ENOMEM if there's no memory
>>   */
>>  static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>> -                                    const struct qstr *qstr, const char **name,
>> -                                    void **value, size_t *len)
>> +                                    const struct qstr *qstr,
>> +                                    struct xattr *xattrs,
>> +                                    int *num_filled_xattrs)
> I'll leave this up to Casey, but 'xattr_count' would be my vote :)

I don't care whether you make the xattr_count change or not. I agree that if
you do change it elsewhere you should change it here, too.

>>  {
>>         struct inode_smack *issp = smack_inode(inode);
>>         struct smack_known *skp = smk_of_current();
>>         struct smack_known *isp = smk_of_inode(inode);
>>         struct smack_known *dsp = smk_of_inode(dir);
>> +       struct xattr *xattr = lsm_find_xattr_slot(xattrs, num_filled_xattrs);
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
>> @@ -976,11 +983,12 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
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
>> @@ -4854,6 +4862,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>>         .lbs_ipc = sizeof(struct smack_known *),
>>         .lbs_msg_msg = sizeof(struct smack_known *),
>>         .lbs_superblock = sizeof(struct superblock_smack),
>> +       .lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
>>  };
>>
>>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>> --
>> 2.25.1
