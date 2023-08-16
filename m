Return-Path: <bpf+bounces-7882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CDD77DC79
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 10:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E19728109A
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC28D307;
	Wed, 16 Aug 2023 08:37:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA476C2DF
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 08:37:06 +0000 (UTC)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569653C18;
	Wed, 16 Aug 2023 01:36:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RQh5Q4x4Gz9xrq8;
	Wed, 16 Aug 2023 16:24:58 +0800 (CST)
Received: from [10.81.209.179] (unknown [10.81.209.179])
	by APP1 (Coremail) with SMTP id LxC2BwBXCrpvitxk8zz3AA--.58903S2;
	Wed, 16 Aug 2023 09:36:13 +0100 (CET)
Message-ID: <98959e3d-7543-4a8e-9712-05a3ba04d2c8@huaweicloud.com>
Date: Wed, 16 Aug 2023 10:35:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 03/13] integrity/digest_cache: Add functions to
 populate and search
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, corbet@lwn.net, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,
 mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
 <20230812104616.2190095-4-roberto.sassu@huaweicloud.com>
 <CUSFPINBGDSS.DQ0I19Z9FNR4@suppilovahvero>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CUSFPINBGDSS.DQ0I19Z9FNR4@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBXCrpvitxk8zz3AA--.58903S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr4ftw4kKFyUCry5ZFWfuFg_yoW3Jr1fpa
	s7CF1UKr4rZr13Gw17AF1ayr1SvryvqF47Gw45Wr1ayr4DZr10y3W8Aw1UWFy5Jr48Wa12
	yF4jgr15ur1UXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj46tmwAAsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/14/2023 7:13 PM, Jarkko Sakkinen wrote:
> On Sat Aug 12, 2023 at 1:46 PM EEST, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Add digest_cache_init_htable(), to size a hash table depending on the
>> number of digests to be added to the cache.
>>
>> Add digest_cache_add() and digest_cache_lookup() to respectively add and
>> lookup a digest in the digest cache.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>   security/integrity/digest_cache.c | 131 ++++++++++++++++++++++++++++++
>>   security/integrity/digest_cache.h |  24 ++++++
>>   2 files changed, 155 insertions(+)
>>
>> diff --git a/security/integrity/digest_cache.c b/security/integrity/digest_cache.c
>> index 4201c68171a..d14d84b804b 100644
>> --- a/security/integrity/digest_cache.c
>> +++ b/security/integrity/digest_cache.c
>> @@ -315,3 +315,134 @@ struct digest_cache *digest_cache_get(struct dentry *dentry,
>>   
>>   	return iint->dig_user;
>>   }
>> +
>> +/**
>> + * digest_cache_init_htable - Allocate and initialize the hash table
>> + * @digest_cache: Digest cache
>> + * @num_digests: Number of digests to add to the digest cache
>> + *
>> + * This function allocates and initializes the hash table. Its size is
>> + * determined by the number of digests to add to the digest cache, known
>> + * at this point by the parser calling this function.
>> + *
>> + * Return: Zero on success, a negative value otherwise.
>> + */
>> +int digest_cache_init_htable(struct digest_cache *digest_cache,
>> +			     u64 num_digests)
>> +{
>> +	int i;
>> +
>> +	if (!digest_cache)
>> +		return 0;
>> +
>> +	digest_cache->num_slots = num_digests / DIGEST_CACHE_HTABLE_DEPTH;
>> +	if (!digest_cache->num_slots)
>> +		digest_cache->num_slots = 1;
>> +
>> +	digest_cache->slots = kmalloc_array(num_digests,
>> +					    sizeof(*digest_cache->slots),
>> +					    GFP_KERNEL);
>> +	if (!digest_cache->slots)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < digest_cache->num_slots; i++)
>> +		INIT_HLIST_HEAD(&digest_cache->slots[i]);
>> +
>> +	pr_debug("Initialized %d hash table slots for digest list %s\n",
>> +		 digest_cache->num_slots, digest_cache->path_str);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * digest_cache_add - Add a new digest to the digest cache
>> + * @digest_cache: Digest cache
>> + * @digest: Digest to add
>> + *
>> + * This function, invoked by a digest list parser, adds a digest extracted
>> + * from a digest list to the digest cache.
>> + *
>> + * Return: Zero on success, a negative value on error.
> 
> Nit: previous had a different phrasing "a negative value otherwise".
> 
> I would suggest "a POSIX error code otherwise" for both.

Ok.

>> + */
>> +int digest_cache_add(struct digest_cache *digest_cache, u8 *digest)
>> +{
>> +	struct digest_cache_entry *entry;
>> +	unsigned int key;
>> +	int digest_len;
>> +
>> +	if (!digest_cache)
>> +		return 0;
>> +
>> +	digest_len = hash_digest_size[digest_cache->algo];
>> +
>> +	entry = kmalloc(sizeof(*entry) + digest_len, GFP_KERNEL);
>> +	if (!entry)
>> +		return -ENOMEM;
>> +
>> +	memcpy(entry->digest, digest, digest_len);
>> +
>> +	key = digest_cache_hash_key(digest, digest_cache->num_slots);
>> +	hlist_add_head(&entry->hnext, &digest_cache->slots[key]);
>> +	pr_debug("Add digest %s:%*phN from digest list %s\n",
>> +		 hash_algo_name[digest_cache->algo], digest_len, digest,
>> +		 digest_cache->path_str);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * digest_cache_lookup - Searches a digest in the digest cache
>> + * @digest_cache: Digest cache
>> + * @digest: Digest to search
>> + * @algo: Algorithm of the digest to search
>> + * @pathname: Path of the file whose digest is looked up
>> + *
>> + * This function, invoked by IMA or EVM, searches the calculated digest of
>> + * a file or file metadata in the digest cache acquired with
>> + * digest_cache_get().
>> + *
>> + * Return: Zero if the digest is found, a negative value if not.
>> + */
>> +int digest_cache_lookup(struct digest_cache *digest_cache, u8 *digest,
>> +			enum hash_algo algo, const char *pathname)
>> +{
>> +	struct digest_cache_entry *entry;
>> +	unsigned int key;
>> +	int digest_len;
>> +	int search_depth = 0;
>> +
>> +	if (!digest_cache)
>> +		return -ENOENT;
>> +
>> +	if (digest_cache->algo == HASH_ALGO__LAST) {
>> +		pr_debug("Algorithm not set for digest list %s\n",
>> +			 digest_cache->path_str);
>> +		return -ENOENT;
>> +	}
>> +
>> +	digest_len = hash_digest_size[digest_cache->algo];
>> +
>> +	if (algo != digest_cache->algo) {
>> +		pr_debug("Algo mismatch for file %s, digest %s:%*phN in digest list %s (%s)\n",
>> +			 pathname, hash_algo_name[algo], digest_len, digest,
>> +			 digest_cache->path_str,
>> +			 hash_algo_name[digest_cache->algo]);
>> +		return -ENOENT;
>> +	}
>> +
>> +	key = digest_cache_hash_key(digest, digest_cache->num_slots);
>> +
>> +	hlist_for_each_entry_rcu(entry, &digest_cache->slots[key], hnext) {
>> +		if (!memcmp(entry->digest, digest, digest_len)) {
>> +			pr_debug("Cache hit at depth %d for file %s, digest %s:%*phN in digest list %s\n",
>> +				 search_depth, pathname, hash_algo_name[algo],
>> +				 digest_len, digest, digest_cache->path_str);
>> +			return 0;
>> +		}
>> +
>> +		search_depth++;
>> +	}
>> +
>> +	pr_debug("Cache miss for file %s, digest %s:%*phN in digest list %s\n",
>> +		 pathname, hash_algo_name[algo], digest_len, digest,
>> +		 digest_cache->path_str);
>> +	return -ENOENT;
>> +}
>> diff --git a/security/integrity/digest_cache.h b/security/integrity/digest_cache.h
>> index ff88e8593c6..01cd70f9850 100644
>> --- a/security/integrity/digest_cache.h
>> +++ b/security/integrity/digest_cache.h
>> @@ -66,6 +66,11 @@ static inline unsigned int digest_cache_hash_key(u8 *digest,
>>   void digest_cache_free(struct digest_cache *digest_cache);
>>   struct digest_cache *digest_cache_get(struct dentry *dentry,
>>   				      struct integrity_iint_cache *iint);
>> +int digest_cache_init_htable(struct digest_cache *digest_cache,
>> +			     u64 num_digests);
>> +int digest_cache_add(struct digest_cache *digest_cache, u8 *digest);
>> +int digest_cache_lookup(struct digest_cache *digest_cache, u8 *digest,
>> +			enum hash_algo algo, const char *pathname);
>>   #else
>>   static inline void digest_cache_free(struct digest_cache *digest_cache)
>>   {
>> @@ -77,5 +82,24 @@ digest_cache_get(struct dentry *dentry, struct integrity_iint_cache *iint)
>>   	return NULL;
>>   }
>>   
>> +static inline int digest_cache_init_htable(struct digest_cache *digest_cache,
>> +					   u64 num_digests)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int digest_cache_add(struct digest_cache *digest_cache,
>> +				   u8 *digest)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int digest_cache_lookup(struct digest_cache *digest_cache,
>> +				      u8 *digest, enum hash_algo algo,
>> +				      const char *pathname)
>> +{
>> +	return -ENOENT;
>> +}
>> +
>>   #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
>>   #endif /* _DIGEST_CACHE_H */
>> -- 
>> 2.34.1
> 
> Why all this complexity instead of using xarray?
> 
> https://docs.kernel.org/core-api/xarray.html

Uhm, did I get correctly from the documentation that it isn't the 
optimal solution for hash tables?

Thanks

Roberto


