Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF26785DE
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 20:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjAWTMd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 14:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAWTMc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 14:12:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5123AB9;
        Mon, 23 Jan 2023 11:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674501148; x=1706037148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e+2xrBm5Oxa6stADMb/R8rAt5gik8DAnbKt0wQFfI+8=;
  b=TZVzTMxrIVTyUmZxSLEHoWZ+at+yViyCd8stR8NxaFAF8IXyviljnnVo
   Aj78Q29WlewhJZaYJ8qMpYqeOUPW26hLBlN0zR5k4z1htI+hbof+Xa1YX
   IuZyNfwFahoxUwyoLOjcSgzir+MA86tSzfgLKtkcHB2Mlx4Ggb30I4vxC
   PdhmsGWjzDuNA34w+EicGZkJb1QfwI88c4jGD54uSZXCMBT8BeLg+GDVP
   ZWdx6O9gs6QivoLoPB68C/99+9T/OSe6651saBDqeG96R64hWuSpgo62d
   ieNw73NHT0dt5h3ng9cDmUXZsntIKDOMvmZ2jUEMNI0uhgLe6P0J8EJ0M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390628612"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="390628612"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 11:12:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804317588"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="804317588"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2023 11:12:18 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pK2Er-0005q8-2N;
        Mon, 23 Jan 2023 19:12:17 +0000
Date:   Tue, 24 Jan 2023 03:12:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@meta.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
Message-ID: <202301240259.xwHsyJl4-lkp@intel.com>
References: <20230123171506.71995-4-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123171506.71995-4-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Vernet/bpf-Add-BPF_KFUNC-macro-for-defining-kfuncs/20230124-011804
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230123171506.71995-4-void%40manifault.com
patch subject: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc definitions
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230124/202301240259.xwHsyJl4-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/760b15a8e5d45d6e9925d2439e0d052de969b361
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Vernet/bpf-Add-BPF_KFUNC-macro-for-defining-kfuncs/20230124-011804
        git checkout 760b15a8e5d45d6e9925d2439e0d052de969b361
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/bpf_trace.c:1233: warning: expecting prototype for bpf_lookup_user_key(). Prototype was for BPF_KFUNC() instead
>> kernel/trace/bpf_trace.c:1282: warning: expecting prototype for bpf_lookup_system_key(). Prototype was for BPF_KFUNC() instead
>> kernel/trace/bpf_trace.c:1306: warning: expecting prototype for bpf_key_put(). Prototype was for BPF_KFUNC() instead
>> kernel/trace/bpf_trace.c:1328: warning: expecting prototype for bpf_verify_pkcs7_signature(). Prototype was for BPF_KFUNC() instead


vim +1233 kernel/trace/bpf_trace.c

f92c1e183604c2 Jiri Olsa     2021-12-08  1205  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1206  #ifdef CONFIG_KEYS
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1207  /**
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1208   * bpf_lookup_user_key - lookup a key by its serial
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1209   * @serial: key handle serial number
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1210   * @flags: lookup-specific flags
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1211   *
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1212   * Search a key with a given *serial* and the provided *flags*.
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1213   * If found, increment the reference count of the key by one, and
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1214   * return it in the bpf_key structure.
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1215   *
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1216   * The bpf_key structure must be passed to bpf_key_put() when done
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1217   * with it, so that the key reference count is decremented and the
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1218   * bpf_key structure is freed.
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1219   *
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1220   * Permission checks are deferred to the time the key is used by
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1221   * one of the available key-specific kfuncs.
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1222   *
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1223   * Set *flags* with KEY_LOOKUP_CREATE, to attempt creating a requested
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1224   * special keyring (e.g. session keyring), if it doesn't yet exist.
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1225   * Set *flags* with KEY_LOOKUP_PARTIAL, to lookup a key without waiting
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1226   * for the key construction, and to retrieve uninstantiated keys (keys
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1227   * without data attached to them).
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1228   *
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1229   * Return: a bpf_key pointer with a valid key pointer if the key is found, a
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1230   *         NULL pointer otherwise.
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1231   */
760b15a8e5d45d David Vernet  2023-01-23  1232  BPF_KFUNC(struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags))
f3cf4134c5c6c4 Roberto Sassu 2022-09-20 @1233  {
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1234  	key_ref_t key_ref;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1235  	struct bpf_key *bkey;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1236  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1237  	if (flags & ~KEY_LOOKUP_ALL)
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1238  		return NULL;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1239  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1240  	/*
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1241  	 * Permission check is deferred until the key is used, as the
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1242  	 * intent of the caller is unknown here.
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1243  	 */
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1244  	key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1245  	if (IS_ERR(key_ref))
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1246  		return NULL;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1247  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1248  	bkey = kmalloc(sizeof(*bkey), GFP_KERNEL);
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1249  	if (!bkey) {
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1250  		key_put(key_ref_to_ptr(key_ref));
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1251  		return NULL;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1252  	}
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1253  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1254  	bkey->key = key_ref_to_ptr(key_ref);
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1255  	bkey->has_ref = true;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1256  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1257  	return bkey;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1258  }
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1259  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1260  /**
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1261   * bpf_lookup_system_key - lookup a key by a system-defined ID
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1262   * @id: key ID
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1263   *
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1264   * Obtain a bpf_key structure with a key pointer set to the passed key ID.
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1265   * The key pointer is marked as invalid, to prevent bpf_key_put() from
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1266   * attempting to decrement the key reference count on that pointer. The key
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1267   * pointer set in such way is currently understood only by
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1268   * verify_pkcs7_signature().
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1269   *
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1270   * Set *id* to one of the values defined in include/linux/verification.h:
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1271   * 0 for the primary keyring (immutable keyring of system keys);
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1272   * VERIFY_USE_SECONDARY_KEYRING for both the primary and secondary keyring
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1273   * (where keys can be added only if they are vouched for by existing keys
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1274   * in those keyrings); VERIFY_USE_PLATFORM_KEYRING for the platform
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1275   * keyring (primarily used by the integrity subsystem to verify a kexec'ed
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1276   * kerned image and, possibly, the initramfs signature).
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1277   *
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1278   * Return: a bpf_key pointer with an invalid key pointer set from the
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1279   *         pre-determined ID on success, a NULL pointer otherwise
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1280   */
760b15a8e5d45d David Vernet  2023-01-23  1281  BPF_KFUNC(struct bpf_key *bpf_lookup_system_key(u64 id))
f3cf4134c5c6c4 Roberto Sassu 2022-09-20 @1282  {
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1283  	struct bpf_key *bkey;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1284  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1285  	if (system_keyring_id_check(id) < 0)
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1286  		return NULL;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1287  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1288  	bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1289  	if (!bkey)
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1290  		return NULL;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1291  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1292  	bkey->key = (struct key *)(unsigned long)id;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1293  	bkey->has_ref = false;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1294  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1295  	return bkey;
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1296  }
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1297  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1298  /**
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1299   * bpf_key_put - decrement key reference count if key is valid and free bpf_key
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1300   * @bkey: bpf_key structure
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1301   *
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1302   * Decrement the reference count of the key inside *bkey*, if the pointer
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1303   * is valid, and free *bkey*.
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1304   */
760b15a8e5d45d David Vernet  2023-01-23  1305  BPF_KFUNC(void bpf_key_put(struct bpf_key *bkey))
f3cf4134c5c6c4 Roberto Sassu 2022-09-20 @1306  {
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1307  	if (bkey->has_ref)
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1308  		key_put(bkey->key);
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1309  
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1310  	kfree(bkey);
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1311  }
f3cf4134c5c6c4 Roberto Sassu 2022-09-20  1312  
865b0566d8f1a0 Roberto Sassu 2022-09-20  1313  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
865b0566d8f1a0 Roberto Sassu 2022-09-20  1314  /**
865b0566d8f1a0 Roberto Sassu 2022-09-20  1315   * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
865b0566d8f1a0 Roberto Sassu 2022-09-20  1316   * @data_ptr: data to verify
865b0566d8f1a0 Roberto Sassu 2022-09-20  1317   * @sig_ptr: signature of the data
865b0566d8f1a0 Roberto Sassu 2022-09-20  1318   * @trusted_keyring: keyring with keys trusted for signature verification
865b0566d8f1a0 Roberto Sassu 2022-09-20  1319   *
865b0566d8f1a0 Roberto Sassu 2022-09-20  1320   * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
865b0566d8f1a0 Roberto Sassu 2022-09-20  1321   * with keys in a keyring referenced by *trusted_keyring*.
865b0566d8f1a0 Roberto Sassu 2022-09-20  1322   *
865b0566d8f1a0 Roberto Sassu 2022-09-20  1323   * Return: 0 on success, a negative value on error.
865b0566d8f1a0 Roberto Sassu 2022-09-20  1324   */
760b15a8e5d45d David Vernet  2023-01-23  1325  BPF_KFUNC(int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
865b0566d8f1a0 Roberto Sassu 2022-09-20  1326  					 struct bpf_dynptr_kern *sig_ptr,
760b15a8e5d45d David Vernet  2023-01-23  1327  					 struct bpf_key *trusted_keyring))
865b0566d8f1a0 Roberto Sassu 2022-09-20 @1328  {
865b0566d8f1a0 Roberto Sassu 2022-09-20  1329  	int ret;
865b0566d8f1a0 Roberto Sassu 2022-09-20  1330  
865b0566d8f1a0 Roberto Sassu 2022-09-20  1331  	if (trusted_keyring->has_ref) {
865b0566d8f1a0 Roberto Sassu 2022-09-20  1332  		/*
865b0566d8f1a0 Roberto Sassu 2022-09-20  1333  		 * Do the permission check deferred in bpf_lookup_user_key().
865b0566d8f1a0 Roberto Sassu 2022-09-20  1334  		 * See bpf_lookup_user_key() for more details.
865b0566d8f1a0 Roberto Sassu 2022-09-20  1335  		 *
865b0566d8f1a0 Roberto Sassu 2022-09-20  1336  		 * A call to key_task_permission() here would be redundant, as
865b0566d8f1a0 Roberto Sassu 2022-09-20  1337  		 * it is already done by keyring_search() called by
865b0566d8f1a0 Roberto Sassu 2022-09-20  1338  		 * find_asymmetric_key().
865b0566d8f1a0 Roberto Sassu 2022-09-20  1339  		 */
865b0566d8f1a0 Roberto Sassu 2022-09-20  1340  		ret = key_validate(trusted_keyring->key);
865b0566d8f1a0 Roberto Sassu 2022-09-20  1341  		if (ret < 0)
865b0566d8f1a0 Roberto Sassu 2022-09-20  1342  			return ret;
865b0566d8f1a0 Roberto Sassu 2022-09-20  1343  	}
865b0566d8f1a0 Roberto Sassu 2022-09-20  1344  
865b0566d8f1a0 Roberto Sassu 2022-09-20  1345  	return verify_pkcs7_signature(data_ptr->data,
865b0566d8f1a0 Roberto Sassu 2022-09-20  1346  				      bpf_dynptr_get_size(data_ptr),
865b0566d8f1a0 Roberto Sassu 2022-09-20  1347  				      sig_ptr->data,
865b0566d8f1a0 Roberto Sassu 2022-09-20  1348  				      bpf_dynptr_get_size(sig_ptr),
865b0566d8f1a0 Roberto Sassu 2022-09-20  1349  				      trusted_keyring->key,
865b0566d8f1a0 Roberto Sassu 2022-09-20  1350  				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
865b0566d8f1a0 Roberto Sassu 2022-09-20  1351  				      NULL);
865b0566d8f1a0 Roberto Sassu 2022-09-20  1352  }
865b0566d8f1a0 Roberto Sassu 2022-09-20  1353  #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
865b0566d8f1a0 Roberto Sassu 2022-09-20  1354  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
