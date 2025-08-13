Return-Path: <bpf+bounces-65541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09012B254B2
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD777B3187
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD22D0617;
	Wed, 13 Aug 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgXkCY+4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F02FD7A2;
	Wed, 13 Aug 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118128; cv=none; b=scT/NKCXHwAosc3Awf9n5MJnlQoH5hxbx52Xbf6UyPxhtTLCOp8GO7HOBbKv2cgMesbkkrrb4VmPGvfyU6jBOq47P9GX3dykMQugEwu2tJyx1V29jT1D+oITOGVFXKBgBm1B/KQxAva0m0OKYxJ4as7HVE/gbU1TZGAiKSdjyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118128; c=relaxed/simple;
	bh=PgXPt7HUxceyhvTpIsrdpg+x5ZSykD0yX1KPHBbs9g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldZV6I0R7lwA0Rlcq/COkil1RV7mh542pTsx8xRDLZ5fKTVaI8DjnfdNGOgRSU1SiBky4u3i8rQkMEPdmX/Ydb6R9QlFEdf+cxivQpFD8ZPQV3IcEqTc3fE3JANxzYJ6ux/2Vig7XKqXK7WVKdEaq/zke1r+6q++7Yo8zLhbjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgXkCY+4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755118126; x=1786654126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PgXPt7HUxceyhvTpIsrdpg+x5ZSykD0yX1KPHBbs9g4=;
  b=VgXkCY+4OfJ65kNcV75dtoiEiUP6dKXpArbppBMvpUTVj59/LNz4wd8h
   bRYQtlQTsRTUO6E5tisRiB2B364gKQPRGSH3NCv8pE1HdvXGhOXgkYA8Z
   bUfEaBnnQX3SHy+XPq7E7Sm3QgoZQ3/6+o06k0VGDTmu4mG56cw08FMYt
   +GSvh8c2gfoZEhYiSz8UjiZ8o3g5igkWEDraLBnFucl53fsPGPkNXb3Yi
   np5toHzs+17r5tJSu6F5wEKKzVpVYXzDPFm6gGirlZqLZ97RiLZ7b779z
   rnUradX3Gou+KXZ8xd7fxQSTjLdZeyVXAuogNo5G1bebDMJTzg8AksgTL
   Q==;
X-CSE-ConnectionGUID: T5KeyP69RlST6ShQbVIGPg==
X-CSE-MsgGUID: h+L3bCD8RLyC7RdRyb4WWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57576834"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57576834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 13:48:45 -0700
X-CSE-ConnectionGUID: F4+C6lErRNup9+xFGLOGxg==
X-CSE-MsgGUID: WEyceoqrRzWLZdAUxD+cPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="203748409"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 13 Aug 2025 13:48:42 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umINk-000AIy-1n;
	Wed, 13 Aug 2025 20:47:53 +0000
Date: Thu, 14 Aug 2025 04:46:00 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	BPF Mailing List <bpf@vger.kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next] bpf: hashtab - allow
 BPF_MAP_LOOKUP{,_AND_DELETE}_BATCH with NULL keys/values.
Message-ID: <202508140435.GA2XXxaK-lkp@intel.com>
References: <20250813073955.1775315-1-maze@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813073955.1775315-1-maze@google.com>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-enczykowski/bpf-hashtab-allow-BPF_MAP_LOOKUP-_AND_DELETE-_BATCH-with-NULL-keys-values/20250813-154227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250813073955.1775315-1-maze%40google.com
patch subject: [PATCH bpf-next] bpf: hashtab - allow BPF_MAP_LOOKUP{,_AND_DELETE}_BATCH with NULL keys/values.
config: csky-randconfig-001-20250814 (https://download.01.org/0day-ci/archive/20250814/202508140435.GA2XXxaK-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508140435.GA2XXxaK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508140435.GA2XXxaK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/hashtab.c: In function '__htab_map_lookup_and_delete_batch':
>> kernel/bpf/hashtab.c:1875:34: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
    1875 |         if (bucket_cnt && (ukeys && copy_to_user(ukeys + total * key_size, keys,
         |                            ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1876 |             key_size * bucket_cnt) ||
         |             ~~~~~~~~~~~~~~~~~~~~~~


vim +1875 kernel/bpf/hashtab.c

  1675	
  1676	static int
  1677	__htab_map_lookup_and_delete_batch(struct bpf_map *map,
  1678					   const union bpf_attr *attr,
  1679					   union bpf_attr __user *uattr,
  1680					   bool do_delete, bool is_lru_map,
  1681					   bool is_percpu)
  1682	{
  1683		struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
  1684		void *keys = NULL, *values = NULL, *value, *dst_key, *dst_val;
  1685		void __user *uvalues = u64_to_user_ptr(attr->batch.values);
  1686		void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
  1687		void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
  1688		u32 batch, max_count, size, bucket_size, map_id;
  1689		u32 bucket_cnt, total, key_size, value_size;
  1690		struct htab_elem *node_to_free = NULL;
  1691		u64 elem_map_flags, map_flags;
  1692		struct hlist_nulls_head *head;
  1693		struct hlist_nulls_node *n;
  1694		unsigned long flags = 0;
  1695		bool locked = false;
  1696		struct htab_elem *l;
  1697		struct bucket *b;
  1698		int ret = 0;
  1699	
  1700		elem_map_flags = attr->batch.elem_flags;
  1701		if ((elem_map_flags & ~BPF_F_LOCK) ||
  1702		    ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
  1703			return -EINVAL;
  1704	
  1705		map_flags = attr->batch.flags;
  1706		if (map_flags)
  1707			return -EINVAL;
  1708	
  1709		max_count = attr->batch.count;
  1710		if (!max_count)
  1711			return 0;
  1712	
  1713		if (put_user(0, &uattr->batch.count))
  1714			return -EFAULT;
  1715	
  1716		batch = 0;
  1717		if (ubatch && copy_from_user(&batch, ubatch, sizeof(batch)))
  1718			return -EFAULT;
  1719	
  1720		if (batch >= htab->n_buckets)
  1721			return -ENOENT;
  1722	
  1723		key_size = htab->map.key_size;
  1724		value_size = htab->map.value_size;
  1725		size = round_up(value_size, 8);
  1726		if (is_percpu)
  1727			value_size = size * num_possible_cpus();
  1728		total = 0;
  1729		/* while experimenting with hash tables with sizes ranging from 10 to
  1730		 * 1000, it was observed that a bucket can have up to 5 entries.
  1731		 */
  1732		bucket_size = 5;
  1733	
  1734	alloc:
  1735		/* We cannot do copy_from_user or copy_to_user inside
  1736		 * the rcu_read_lock. Allocate enough space here.
  1737		 */
  1738		keys = kvmalloc_array(key_size, bucket_size, GFP_USER | __GFP_NOWARN);
  1739		values = kvmalloc_array(value_size, bucket_size, GFP_USER | __GFP_NOWARN);
  1740		if (!keys || !values) {
  1741			ret = -ENOMEM;
  1742			goto after_loop;
  1743		}
  1744	
  1745	again:
  1746		bpf_disable_instrumentation();
  1747		rcu_read_lock();
  1748	again_nocopy:
  1749		dst_key = keys;
  1750		dst_val = values;
  1751		b = &htab->buckets[batch];
  1752		head = &b->head;
  1753		/* do not grab the lock unless need it (bucket_cnt > 0). */
  1754		if (locked) {
  1755			ret = htab_lock_bucket(b, &flags);
  1756			if (ret) {
  1757				rcu_read_unlock();
  1758				bpf_enable_instrumentation();
  1759				goto after_loop;
  1760			}
  1761		}
  1762	
  1763		bucket_cnt = 0;
  1764		hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
  1765			bucket_cnt++;
  1766	
  1767		if (bucket_cnt && !locked) {
  1768			locked = true;
  1769			goto again_nocopy;
  1770		}
  1771	
  1772		if (bucket_cnt > (max_count - total)) {
  1773			if (total == 0)
  1774				ret = -ENOSPC;
  1775			/* Note that since bucket_cnt > 0 here, it is implicit
  1776			 * that the locked was grabbed, so release it.
  1777			 */
  1778			htab_unlock_bucket(b, flags);
  1779			rcu_read_unlock();
  1780			bpf_enable_instrumentation();
  1781			goto after_loop;
  1782		}
  1783	
  1784		if (bucket_cnt > bucket_size) {
  1785			bucket_size = bucket_cnt;
  1786			/* Note that since bucket_cnt > 0 here, it is implicit
  1787			 * that the locked was grabbed, so release it.
  1788			 */
  1789			htab_unlock_bucket(b, flags);
  1790			rcu_read_unlock();
  1791			bpf_enable_instrumentation();
  1792			kvfree(keys);
  1793			kvfree(values);
  1794			goto alloc;
  1795		}
  1796	
  1797		/* Next block is only safe to run if you have grabbed the lock */
  1798		if (!locked)
  1799			goto next_batch;
  1800	
  1801		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
  1802			memcpy(dst_key, l->key, key_size);
  1803	
  1804			if (is_percpu) {
  1805				int off = 0, cpu;
  1806				void __percpu *pptr;
  1807	
  1808				pptr = htab_elem_get_ptr(l, map->key_size);
  1809				for_each_possible_cpu(cpu) {
  1810					copy_map_value_long(&htab->map, dst_val + off, per_cpu_ptr(pptr, cpu));
  1811					check_and_init_map_value(&htab->map, dst_val + off);
  1812					off += size;
  1813				}
  1814			} else {
  1815				value = htab_elem_value(l, key_size);
  1816				if (is_fd_htab(htab)) {
  1817					struct bpf_map **inner_map = value;
  1818	
  1819					 /* Actual value is the id of the inner map */
  1820					map_id = map->ops->map_fd_sys_lookup_elem(*inner_map);
  1821					value = &map_id;
  1822				}
  1823	
  1824				if (elem_map_flags & BPF_F_LOCK)
  1825					copy_map_value_locked(map, dst_val, value,
  1826							      true);
  1827				else
  1828					copy_map_value(map, dst_val, value);
  1829				/* Zeroing special fields in the temp buffer */
  1830				check_and_init_map_value(map, dst_val);
  1831			}
  1832			if (do_delete) {
  1833				hlist_nulls_del_rcu(&l->hash_node);
  1834	
  1835				/* bpf_lru_push_free() will acquire lru_lock, which
  1836				 * may cause deadlock. See comments in function
  1837				 * prealloc_lru_pop(). Let us do bpf_lru_push_free()
  1838				 * after releasing the bucket lock.
  1839				 *
  1840				 * For htab of maps, htab_put_fd_value() in
  1841				 * free_htab_elem() may acquire a spinlock with bucket
  1842				 * lock being held and it violates the lock rule, so
  1843				 * invoke free_htab_elem() after unlock as well.
  1844				 */
  1845				l->batch_flink = node_to_free;
  1846				node_to_free = l;
  1847			}
  1848			dst_key += key_size;
  1849			dst_val += value_size;
  1850		}
  1851	
  1852		htab_unlock_bucket(b, flags);
  1853		locked = false;
  1854	
  1855		while (node_to_free) {
  1856			l = node_to_free;
  1857			node_to_free = node_to_free->batch_flink;
  1858			if (is_lru_map)
  1859				htab_lru_push_free(htab, l);
  1860			else
  1861				free_htab_elem(htab, l);
  1862		}
  1863	
  1864	next_batch:
  1865		/* If we are not copying data, we can go to next bucket and avoid
  1866		 * unlocking the rcu.
  1867		 */
  1868		if (!bucket_cnt && (batch + 1 < htab->n_buckets)) {
  1869			batch++;
  1870			goto again_nocopy;
  1871		}
  1872	
  1873		rcu_read_unlock();
  1874		bpf_enable_instrumentation();
> 1875		if (bucket_cnt && (ukeys && copy_to_user(ukeys + total * key_size, keys,
  1876		    key_size * bucket_cnt) ||
  1877		    uvalues && copy_to_user(uvalues + total * value_size, values,
  1878		    value_size * bucket_cnt))) {
  1879			ret = -EFAULT;
  1880			goto after_loop;
  1881		}
  1882	
  1883		total += bucket_cnt;
  1884		batch++;
  1885		if (batch >= htab->n_buckets) {
  1886			ret = -ENOENT;
  1887			goto after_loop;
  1888		}
  1889		goto again;
  1890	
  1891	after_loop:
  1892		if (ret == -EFAULT)
  1893			goto out;
  1894	
  1895		/* copy # of entries and next batch */
  1896		ubatch = u64_to_user_ptr(attr->batch.out_batch);
  1897		if (copy_to_user(ubatch, &batch, sizeof(batch)) ||
  1898		    put_user(total, &uattr->batch.count))
  1899			ret = -EFAULT;
  1900	
  1901	out:
  1902		kvfree(keys);
  1903		kvfree(values);
  1904		return ret;
  1905	}
  1906	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

