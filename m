Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353444EE599
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 03:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbiDABM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 21:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiDABM4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 21:12:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8627C3DDDC;
        Thu, 31 Mar 2022 18:11:04 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22VNFrRr010862;
        Thu, 31 Mar 2022 18:11:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id : mime-version;
 s=facebook; bh=qlLgtJFNO9h/QDi5dLuw+sKCjltuxDaqs4oDWfG743Q=;
 b=Ic7Up5cl+jtBYo7QSRUyLig8FbDJ9DDnshdSuih5q7buXUMiV+wXvOTHKNfGaDtCi+Le
 Fcdl75th0rwLsW0NG1f5aY+Uro4F+KQfxsOTsgrUyyvd7fBbCnDm5MkQnnOwBCdqpzcc
 dr1sWTSA7Ek8dkSnSOPnMxlJhkh5oqhhoYc= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f5gpck7k2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 18:11:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeMsLvKi4CpLoTs8+CWSyngxh6VPyFF1ZPJcTcXhyPahYNoO+kK/FkD9t9s22w9FiMCmNpAJlZfxygW69+1jt+R7coFRdo9F7Fp90WgGUFQ34mjOXeIQ/12lXKPuKLTanHT6N6clV7gYgV79yqb9ZNgjXkm8tpisPQN0jrtDgAyHvIkIEie6dysYLyiAFQ5q+Oizwgxs7MxpXlMvStP/W9LleAFdr8VpaBFFva0M6Lt1J5nprLeEsgaRKCc0JtCaYTBivQTU8+Vm5gUgHw/+BLMfUG6R/QvrM9pMlweZ7lxzmz3oKt2UJOOz4qf6JjB5VgnYlBRgT2WfFC935GbsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlLgtJFNO9h/QDi5dLuw+sKCjltuxDaqs4oDWfG743Q=;
 b=kRgCiYXyPzl1V7xkJ/t06VTymzb1zTEXfR79Pn+S+aWcy8Dmes88TWZwknSZv2D4hUbiX97l8Yham0GNNYCQdRiVk/bctaewDzSqU9Pj5Ey4Pdnu35qw4Ju88x9UvmS35A1XhOjTVv/EZzbYAMpM/jMklirhGWWYV2gNAcUpzUIPo67Al2z65AxgbCkMHCcwRDBGHcJ8POyn9Uq59QXL5qEglkrgi3yUCHFrAoD59y+DyH7dNj/DOnKmwGAgacWAABKSml+t2vvoaT7Lai/D+s5qFsu/2oCT0TPioVtMRJH2395YtmH3YFJQjtsXYMTJ2rNabOjZ4+V9NxIPDjFkKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4455.namprd15.prod.outlook.com (2603:10b6:a03:374::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 01:11:01 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::58c9:859d:dc03:3bb4]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::58c9:859d:dc03:3bb4%3]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 01:11:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: ftrace_direct (used by bpf trampoline) conflicts with live patch
Thread-Topic: ftrace_direct (used by bpf trampoline) conflicts with live patch
Thread-Index: AQHYRWVZy71R0I55UEO8sKeBatX2ng==
Date:   Fri, 1 Apr 2022 01:11:01 +0000
Message-ID: <0962AC9B-2FBD-4578-8B2F-A376A6B3B83F@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dc4c255-7143-4e1c-7288-08da137c7c7e
x-ms-traffictypediagnostic: SJ0PR15MB4455:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB44555C10DF0EF5540BF1BC32B3E09@SJ0PR15MB4455.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWyhGJUZqCoNV4jxSuv6LC9SvFOOmeP+T6LiaGIxPN7sNwEF4eMh1lp3trswcRdfrzERySQeKUamMAQMG3rfGvHtoPxX1M+GIzf5Bh5+C4PSAGxPR2MbqtIqioj7gHKlN/ZtEl0jRz+WtwCsQymfMVfodEbQY0WjRLSbNgDdzZC1pV7S6zQ3hU/D+mG457v60Qdzbp3EpzZiExDettrHNFXBSeWI5LGqG4aGTaGEJBABmuqDWTFQ+jkxBwF9T84lB1vZGFXKTbCTPx7ZZlVPzBP4kEgEB2bB9pyUshSUkUOGYabOm0PCINxDDYUT85Vo5PpsfFtB3QmACkkRNULFzjs1MQiwnZpFw44T/onvq7ZMhBne5jn8bH+h3eyHQEYe1QnyBL6kB1gPQnzn/aJp9BcXbr47YfSSZ9YBBsnnqgpQfcU526WGBGv5MRP3og+BDr/yZsOcPYBc+wUcn1JQW/RQpWJeyePjk9GCkGrnB/UacBnCEBX/0Tc/wl0HP+9xy7iz1jDAvHFFcol8VRKysXYU+i/Xw9AU5cMVChbb3t7Fu3GAa6a7yvQ3KIxNi3U0RfRouXuUpwjTkHWwfDhCzq+N11jeKaNIszbyLgbYCEDM7ljx3RC85D00R8vWqyj7pwAcx1nJIGLrTM8H1Dj6jR1em2GgXjKp7AT4e7G7xh5jHx9KGrR92HiacrGvBHrPitJZAHCTJmTVKxQgHMhdYM133CgUyMYtfaUJfkA3sp42MtFTh3EsYZLrF0KFGU2P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(54906003)(2616005)(122000001)(38070700005)(2906002)(316002)(6486002)(6512007)(6506007)(6916009)(71200400001)(66946007)(76116006)(86362001)(66556008)(4326008)(5660300002)(8676002)(33656002)(66476007)(508600001)(64756008)(66446008)(38100700002)(91956017)(8936002)(83380400001)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?loeHn04ZAGu8n8XL1Qvo8YAXwIk2EUNLPlpuMT2wA3kOD9S5mRF9Z8cDHNU8?=
 =?us-ascii?Q?D3OuQO5qqgzf0KfA/7q8Dl8FiHfzaavHnuCpWQPL96NyswVdSFqVG9lJLWvd?=
 =?us-ascii?Q?pbNC/0ORq1WXA+YIRCEqraUcIaDFUGa+SZ+TOp8SvwB+eJh3i2PXHMnAxtNP?=
 =?us-ascii?Q?Nrv3CA/cReBV71yIcOTfnR3AUmLH2f1mg8/Or7fdnYzaonDOwbSWP7IDj8bZ?=
 =?us-ascii?Q?mqg4IkugNvOg6L5CElekqBHmiqHeMs5lG4IPDm0ershLh1R5brzPnxTTrAgt?=
 =?us-ascii?Q?kVhlxhUYz8Ca1x8OaBkGB9pNsZ++PZM8JFYvbjJCYx+9jHHO+vm0cWHoYvrQ?=
 =?us-ascii?Q?CcjYXQnKK9My6hD3GTYAstKuJP9PWhlNuqbeDc/x9BHHE3GKctGlT5dbBHkY?=
 =?us-ascii?Q?VjJWXH1vI9qUQY6dkgR6cv/cdVGNABVnV3xe+DyILqTwy/qtET+akaXYWT3o?=
 =?us-ascii?Q?cJcTXYYlRu8ks8QUVVVZYMej5iquFUTzeK1dwfQuVn0+wTiwkvsqiKR9SNdl?=
 =?us-ascii?Q?VafT5XcPYN+eZZop/jwKLlkHPoog+ZlbJUlBpO3P24f7G9DhSyNkKiOGAYm7?=
 =?us-ascii?Q?VUkrLucUcfGEh20Xauw5kcji5Ezl8G4+noZv5aadR3I3ckUX4zv37BF8qab5?=
 =?us-ascii?Q?UII3LMlgD9b9nD2lnExsqWUtWVF6v6OtrM2pGxUzcunITkSOOOodDstln+Ys?=
 =?us-ascii?Q?hI7xOPFq4iZ5Ikp7iJ24u44Qt+d2n3LzL3seOTMSMLrqgZhJqNjKlCePKaEd?=
 =?us-ascii?Q?YtE5e8hRbU5vGNZKRiqlJ0l6gO/Ytw0Yzhv8RoJAyVDT1PEiqSAjT/lRR61c?=
 =?us-ascii?Q?JzUNXzPzQ9rn1aE1RfwZ7nyzhrWiE3eweNEY+ORrw6tPnn1ujOdQ0Vo43cp5?=
 =?us-ascii?Q?N9zQkUD94IFWJyzF94tlf0+IyiPfSIr9gLU7E+Xw7DAo1RYuc+UubB4EqGPA?=
 =?us-ascii?Q?nJVfESbI5+FeGs8jB8iBffnm4w2cXmLifcVzvfVNb1JRhSrwMwPgqB9XeYU9?=
 =?us-ascii?Q?AyvmwjXha5sKfAWhvVjesyXgOmvpG4Y6FDn8uPd9+A8vytC43LaKfolAt5//?=
 =?us-ascii?Q?i8hdCUsjL7ZriapBqrZ8ieikxF8WZtLCpA4j+WlcYRdyZ671DOGJxrZRE/pe?=
 =?us-ascii?Q?/szYYF97JsvYw9oerXQca9xmfDrXU4dMeHRWB6QWlGm+I9xnXhGVApfAh55S?=
 =?us-ascii?Q?YgFQe8cQ3j8OnM7svDWDaQ+LbzOe7+BBMiOJOPy+oSEqPsqXrhRiXlAMNNnn?=
 =?us-ascii?Q?Kh54Y9lgPmj/nVCjUgZKuDvCOiEwKXhGRYu920JynwoQh3SPp0W9JPd250iN?=
 =?us-ascii?Q?D/o/SUUjNWX4AUHDXbMagQFc3px8fe0uD7vb6HAQqogIRS8O6nJkR68xJMBP?=
 =?us-ascii?Q?XJ1wED8V3dCaOBThI0nCaCuxNB2sXHV5mIDTGS4f6VzE3fLBkYywZL6MEaAp?=
 =?us-ascii?Q?geVLd0nhdw/F+OJpHMND0Iuej70YRQMdbTGGbk0pk2XFAJPcHa8Zi7Wcwby4?=
 =?us-ascii?Q?vjpOozJbJix589Zn6YZTBukwlaPrdGbT2b5mZISSawXNVStYgD1B9yayem0P?=
 =?us-ascii?Q?Cg5HWPj6Y5rf1ervG8tEJJccRayLPwoXv20Me3SC2WK7r/abTFl7BRIx4xvg?=
 =?us-ascii?Q?9MsbS3FIAocPm+zmvN4skX8+BqBUKo4zVerhafNMfVjJNMAtsK9ZPCOaXItL?=
 =?us-ascii?Q?1REB1Ufw3Gt1+7X7wAivMoT79F5+ZVQmnisGx00UczdfebzmZh4WiD1pkExO?=
 =?us-ascii?Q?y/t8ZEUCl/gZPc+DcWXrQicNY+tXdEWUMr1ld+xQG+r6AIZD8ZyX?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25FD766B1AF48B43917ABFC70E1DFEBF@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc4c255-7143-4e1c-7288-08da137c7c7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 01:11:01.1255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HiGeaZls1JM2DOA9RRhSI5R9xMa9g4iAY7VRWY518lsdYO6Gk+AumXE37ZXP0CqI4nAlodURCH1wrhSi/pkInQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4455
X-Proofpoint-ORIG-GUID: mmOVksDYiXRomkPagsRIAjLgwKwgN054
X-Proofpoint-GUID: mmOVksDYiXRomkPagsRIAjLgwKwgN054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_06,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Steven, 

We hit an issue with bpf trampoline and kernel live patch on the 
same function. 

Basically, we have tracing and live patch on the same function. 
If we use kprobe (over ftrace) for tracing, it works fine with 
live patch. However, fentry on the same function does not work 
with live patch (the one comes later fails to attach).

After digging into this, I found this is because bpf trampoline
uses register_ftrace_direct, which enables IPMODIFY by default. 
OTOH, it seems that BPF doesn't really need IPMODIFY. As BPF 
trampoline does a "goto do_fexit" in jit for BPF_TRAMP_MODIFY_RETURN.

IIUC, we can let bpf trampoline and live patch work together with
an ipmodify-less version of register_ftrace_direct, like attached 
below. 

Does this make sense to you? Did I miss something?

Thanks in advance,
Song



diff --git i/include/linux/ftrace.h w/include/linux/ftrace.h
index ed8cf433a46a..46c40f0e0368 100644
--- i/include/linux/ftrace.h
+++ w/include/linux/ftrace.h
@@ -326,6 +326,8 @@ struct dyn_ftrace;
 extern int ftrace_direct_func_count;
 int register_ftrace_direct(unsigned long ip, unsigned long addr);
 int unregister_ftrace_direct(unsigned long ip, unsigned long addr);
+int register_ftrace_direct_no_ipmodify(unsigned long ip, unsigned long addr);
+int unregister_ftrace_direct_no_ipmodify(unsigned long ip, unsigned long addr);
 int modify_ftrace_direct(unsigned long ip, unsigned long old_addr, unsigned long new_addr);
 struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr);
 int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
diff --git i/kernel/bpf/trampoline.c w/kernel/bpf/trampoline.c
index ada97751ae1b..52ff503692cb 100644
--- i/kernel/bpf/trampoline.c
+++ w/kernel/bpf/trampoline.c
@@ -123,7 +123,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct((long)ip, (long)old_addr);
+		ret = unregister_ftrace_direct_no_ipmodify((long)ip, (long)old_addr);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
 
@@ -159,7 +159,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 		return -ENOENT;
 
 	if (tr->func.ftrace_managed)
-		ret = register_ftrace_direct((long)ip, (long)new_addr);
+		ret = register_ftrace_direct_no_ipmodify((long)ip, (long)new_addr);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
 
diff --git i/kernel/trace/ftrace.c w/kernel/trace/ftrace.c
index 4f1d2f5e7263..afb5598c103f 100644
--- i/kernel/trace/ftrace.c
+++ w/kernel/trace/ftrace.c
@@ -2467,6 +2467,20 @@ struct ftrace_ops direct_ops = {
 	 */
 	.trampoline	= FTRACE_REGS_ADDR,
 };
+
+struct ftrace_ops no_ipmodify_direct_ops = {
+	.func		= call_direct_funcs,
+	.flags		= FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
+			  | FTRACE_OPS_FL_PERMANENT,
+	/*
+	 * By declaring the main trampoline as this trampoline
+	 * it will never have one allocated for it. Allocated
+	 * trampolines should not call direct functions.
+	 * The direct_ops should only be called by the builtin
+	 * ftrace_regs_caller trampoline.
+	 */
+	.trampoline	= FTRACE_REGS_ADDR,
+};
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
@@ -5126,6 +5140,9 @@ static struct ftrace_direct_func *ftrace_alloc_direct_func(unsigned long addr)
 	return direct;
 }
 
+static int __register_ftrace_direct(unsigned long ip, unsigned long addr,
+				    struct ftrace_ops *ops);
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * @ip: The address of the nop at the beginning of a function
@@ -5144,6 +5161,12 @@ static struct ftrace_direct_func *ftrace_alloc_direct_func(unsigned long addr)
  *  -ENOMEM - There was an allocation failure.
  */
 int register_ftrace_direct(unsigned long ip, unsigned long addr)
+{
+	return __register_ftrace_direct(ip, addr, &direct_ops);
+}
+
+static int __register_ftrace_direct(unsigned long ip, unsigned long addr,
+				    struct ftrace_ops *ops)
 {
 	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
@@ -5194,14 +5217,14 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	if (!entry)
 		goto out_unlock;
 
-	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
+	ret = ftrace_set_filter_ip(ops, ip, 0, 0);
 	if (ret)
 		remove_hash_entry(direct_functions, entry);
 
-	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED)) {
-		ret = register_ftrace_function(&direct_ops);
+	if (!ret && !(ops->flags & FTRACE_OPS_FL_ENABLED)) {
+		ret = register_ftrace_function(ops);
 		if (ret)
-			ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
+			ftrace_set_filter_ip(ops, ip, 1, 0);
 	}
 
 	if (ret) {
@@ -5230,6 +5253,29 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
 
+/**
+ * register_ftrace_direct_no_ipmodify - Call a custom trampoline directly.
+ * The custom trampoline should not use IP_MODIFY.
+ * @ip: The address of the nop at the beginning of a function
+ * @addr: The address of the trampoline to call at @ip
+ *
+ * This is used to connect a direct call from the nop location (@ip)
+ * at the start of ftrace traced functions. The location that it calls
+ * (@addr) must be able to handle a direct call, and save the parameters
+ * of the function being traced, and restore them (or inject new ones
+ * if needed), before returning.
+ *
+ * Returns:
+ *  0 on success
+ *  -EBUSY - Another direct function is already attached (there can be only one)
+ *  -ENODEV - @ip does not point to a ftrace nop location (or not supported)
+ *  -ENOMEM - There was an allocation failure.
+ */
+int register_ftrace_direct_no_ipmodify(unsigned long ip, unsigned long addr)
+{
+	return __register_ftrace_direct(ip, addr, &no_ipmodify_direct_ops);
+}
+
 static struct ftrace_func_entry *find_direct_entry(unsigned long *ip,
 						   struct dyn_ftrace **recp)
 {
@@ -5257,7 +5303,21 @@ static struct ftrace_func_entry *find_direct_entry(unsigned long *ip,
 	return entry;
 }
 
+static int __unregister_ftrace_direct(unsigned long ip, unsigned long addr,
+				      struct ftrace_ops *ops);
+
 int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
+{
+	return __unregister_ftrace_direct(ip, addr, &direct_ops);
+}
+
+int unregister_ftrace_direct_no_ipmodify(unsigned long ip, unsigned long addr)
+{
+	return __unregister_ftrace_direct(ip, addr, &no_ipmodify_direct_ops);
+}
+
+static int __unregister_ftrace_direct(unsigned long ip, unsigned long addr,
+				      struct ftrace_ops *ops)
 {
 	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
@@ -5274,11 +5334,11 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 	if (!entry)
 		goto out_unlock;
 
-	hash = direct_ops.func_hash->filter_hash;
+	hash = ops->func_hash->filter_hash;
 	if (hash->count == 1)
-		unregister_ftrace_function(&direct_ops);
+		unregister_ftrace_function(ops);
 
-	ret = ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
+	ret = ftrace_set_filter_ip(ops, ip, 1, 0);
 
 	WARN_ON(ret);
 
