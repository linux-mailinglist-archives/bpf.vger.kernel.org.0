Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BDE4D31D1
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 16:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiCIPdI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 10:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiCIPdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 10:33:08 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2109.outbound.protection.outlook.com [40.107.243.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBDC125504
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 07:32:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPc/LM70tJ8xUQkEcpt8hROagTTwZ323oqKJLP6fMDTtNXaEMlFIiU9qgEEZiP6JV1MWTDqfvaOPZMo3IZy6IKsy+J6XauK2zVuft3mAc+/+4prtO6zbsceBNEWas8X2vl/VZOqz0xXleC/2KCfxGj2tEH2IcPs4Tix7kmuRwaS1Z5nlbfJg8R6LhOtpk8nqbPW2QZsli27tJ22u4ctgXvws17NHbij0TmHGS2Mv+TFW3kdY6mTw4kQHtRsr5lSqg9RYWiOQa+DH3VRW4znywnbDqOmRrzzSwmHrtgAW3epc49a0kOULIwui9uAlzjQn/ZVd6RvyrWSHBDt91Mc5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mKyPeV4rhA5oPNvdfN2ZlYkz96XTq+fd6/cFmOXd08=;
 b=C8wEzog1Q9CsHn6TESdT01bz7L8qXJcwOFeheUxEjxVpd6MgGYoNYz6Xp3/MtdQ9wNhW7vpH+er6ePhCJAE/NtePfzE6F8tjOL0xVrllq/S8eFJp8TKzcRAwDWEr/MMEQWxpsgsjCngqpn1Ty3vyWZSS0MbsfJYYCEh2y9T57/VmS32d3fKwde1j2R9KkgOZ9uBdnTQHRTEljLrDaK9VwJeZGt0ms8/muj3VDUpcqvUpYVz+stGVVFOh7bTsldepRW0obY7OWnxcYE1A8Cud5FItH7Bn1wbfDjQ7XsgzPe2Ua4ClYHS6agJss3ECUCWsowhbgwq+ryIytnCEGIxdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mKyPeV4rhA5oPNvdfN2ZlYkz96XTq+fd6/cFmOXd08=;
 b=hBLRL9xEiQqelltgZX30euaJfSfMY757jgxbmtv2XT/FVoAiafkK08IyFUpPwX+cYVjQ4S2DgbTQguXtdqG4q/65YWsEvlGNYygMZMswvokskw2hhuuC2+svhPuOg//R0U7lWghquhWsIyhx3Zck4gs2yOhdg2o16J2bHf/o0uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by MWHPR1301MB2016.namprd13.prod.outlook.com (2603:10b6:301:34::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.7; Wed, 9 Mar
 2022 15:32:01 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6%5]) with mapi id 15.20.5061.020; Wed, 9 Mar 2022
 15:32:01 +0000
Date:   Wed, 9 Mar 2022 16:31:55 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@corigine.com>,
        oss-drivers@corigine.com
Subject: Re: [v2,bpf-next] bpftool: Restore support for BPF offload-enabled
 feature probing
Message-ID: <YijIa+P3iBBXekWq@bismarck.dyn.berto.se>
References: <20220309085452.298278-1-niklas.soderlund@corigine.com>
 <a5df60e1-f0b1-070f-7c93-133f0c562a21@isovalent.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5df60e1-f0b1-070f-7c93-133f0c562a21@isovalent.com>
X-ClientProxiedBy: AS8PR05CA0006.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::11) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebfc412e-f1b4-445c-8866-08da01e1f4c9
X-MS-TrafficTypeDiagnostic: MWHPR1301MB2016:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1301MB2016A53B2166FA2A6BC71055E70A9@MWHPR1301MB2016.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XG2RjUlmtrnJOtZ7u4HASPXs7y8yjA3tGILOLktJLbwP5/Dvi6SGEHxQIDTltCiKAnQEoctNnaNEdasXMBMmuXi1dOWS1Nb5OG5EVL9F6qXm1vuRfSRRAzi8zR4LW5B8PBTRJmMhMKQcgUh7GxA2OsYT3y5j6buKEp1Jejlkicg9x6C1g7p6sMSTf2Xjgpx5JkZAwL8ixfvJFc/TtU+Z2JupUmK9PtuONG64AkNuF4SAhHapjZzgha46TM2qqlFb9ZAVLR/cGZOOULu6NVHE11uFuzhIYUb6v7ItZ30U0Nd9Bmh2JxRxH7tZM4PQeAS16pwFuf3aDJ8YcGhchRyy2ROFgB0enzx9g65vY5l0p1y7keZFoDtIim9vCh+Wv13RNi1R5qycOzVnfektO/PLaK1vJz+tZ2/lffVSMO3mAY7t4I4S7fexTEgDZZw+Vv7l094r8xmjsrnNPQF5L2fHO1GBVXljSK/sGQUhAwZjYHrCopH4kh81Tq9Uw4Qjs5M7mlkiteHaEMiEWvEoSXWH6e7kJ8OhcKTVA8f+fR9ZCIuFODiFb98OmX+k9xsHH+D8Xqlu2i+NoJGp8pqAfcoeAyK91KDiDXWC0xNx4mA+q4u/y59xDhbDivi+SAjfJ5NEdC5C1ZdLnXm1sy7KtX3+wHfI3uNdtt8khK9j8GMjTQbAzeK0IZ+zVNjg8fMJlvtkMjA/pchkepZIq/mls3F/BhBQ+MtU+4kB1RDFbDEG3OA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(366004)(136003)(39840400004)(346002)(38100700002)(38350700002)(52116002)(6666004)(86362001)(83380400001)(6486002)(8676002)(508600001)(54906003)(66476007)(6506007)(6916009)(4326008)(316002)(66556008)(66946007)(186003)(26005)(5660300002)(8936002)(66574015)(2906002)(107886003)(6512007)(53546011)(9686003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Zl44/qu1GU9DZeDWPISS0K8tDBLBkz4fx0AcSfU8F37OVc30ELNq94ybmL?=
 =?iso-8859-1?Q?UmI560EmE4b1yHaZee8fLduUXUZZRM9s+RYuJHsxIojeuhV0aIpAoBqiQ+?=
 =?iso-8859-1?Q?YL8gUq729brslZwaIzT72WJGKtR8zPFoc/R5p1oW9Yy7Xdp/cmRXTB49BW?=
 =?iso-8859-1?Q?z5CF7EeDuSn9vury5EhMMHT8/yViX1ce942/palS74bfsq8ySLm6Xa2Yqp?=
 =?iso-8859-1?Q?KUR0OChm1jOFImZk03uR5fHJdEd9lYteNO/gnC63V3mwpd1twCMX3iW9bw?=
 =?iso-8859-1?Q?TyTk2WYXZYjOdiV8nydRUdB8ucbNDhzWEsajcR0X9h+jX7kThryGXe+QtV?=
 =?iso-8859-1?Q?iRfpkSZxisU9GJNh7y59Spk4hhrGLnfKb0qUnNFeQKIDyg/Tniyn+NU7S/?=
 =?iso-8859-1?Q?csbB1XpaxrehhgtMszqj18M+hIl7XZJEBcl+OX5Dh4CgeUzKAJAUVZkxWj?=
 =?iso-8859-1?Q?oM31+Xu3ns8r2/pYYOWvxLvdkV25HwxK/YOk6FWcYKkS9+QfkHgnnfNtZm?=
 =?iso-8859-1?Q?8J6MMAfJVzLnmwp9Zklwvl9YBHzP92Xu6Ez6Y2cJKJaOj2WeKtQbwavyVK?=
 =?iso-8859-1?Q?I94Vt+c054GYPOAb1Sao7UiP9WV8S5TVyVUQm4XpDA31UcAe1oWECxLhRO?=
 =?iso-8859-1?Q?x4iA+6HhOO6FXWAVyG2HR9HXDBS6IEsLpT+ep15t2xzbfyutJMR2D7rgQa?=
 =?iso-8859-1?Q?EG5e5zFTRpKRFguAlN+XwQsGAOi5BDVv0HYFQDPr02+SEQk6Cvl8kNHErg?=
 =?iso-8859-1?Q?SSS06C87YtjPV9nmhdUMQF/sSuYjedj70L8u1pfFPYt+U6dkHLuu0KftI6?=
 =?iso-8859-1?Q?VTfuiT4YJonLb8EoFy44b9fkwk8An9erP+uBtYFh4KsZZGtIxOQjU1yOgU?=
 =?iso-8859-1?Q?DqZkbLkzTW7wdLoVAuL/B8NBBFCp9ik8EPTgfB1BrBrBlFBe+ur0FUYU8E?=
 =?iso-8859-1?Q?1tZZLc4UdSfd7TQ50XnQjTW6N92oG7HsJP7g310lMAj2QFFx8rZgrD9oRC?=
 =?iso-8859-1?Q?zONwU2IEdxQI9lodJjTe4echhDv2NS3nZ/AneOmajEQeCDLhisZASDAckj?=
 =?iso-8859-1?Q?SKXg2106J/e2Oodj+y+Ds2ODbwxtQf3oLfeRT/VnhShjcsS+53cLqeGDxI?=
 =?iso-8859-1?Q?+m68xBaemhuLvyo8K+A3DeJr6EwHazSis2chru7YsX0/CrAirNneDBkOXJ?=
 =?iso-8859-1?Q?ZnmGCvJ0tfrwCIWa+fKHg3yCnHsqpxw5jloCOn04BpkbknCosfEHkDNa23?=
 =?iso-8859-1?Q?7MKzOrEf3AEbRm1Iiot6nqTzep0sXS+ceKZ+l0iuqt6YJZbPFstMugPsPO?=
 =?iso-8859-1?Q?7IDRkGMxaPOKpI2yqGZ31mBgGcfErHyIzKSOslBtmkln5dsbhd0zinfDg4?=
 =?iso-8859-1?Q?uiPZTIULCfUTV5sb9gVrOlq8f1ERc4iJllxRJw2AMdJOtb5Dxn+bJAhTDd?=
 =?iso-8859-1?Q?FbVsQz3o0iA2CfnFye+rVQ1TrsQvqk5lk0ZMHlv6HcmJxUxFDjqdFksW04?=
 =?iso-8859-1?Q?8ovcrydlHgvihG1XdVN/fqL03tyRtu6x/jrArpSOmXDw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfc412e-f1b4-445c-8866-08da01e1f4c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 15:32:01.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMRG0LfplPWSXqKALu3rsq7EJc6c2l8R+ulFj3k0SbxXwHECz7OuojaGjOG5ZJxMi1mfP5otZaJIQ7qHgBxp7LIwjontglIETC+l3zUpcUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB2016
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Quentin,

Thanks for your review.

On 2022-03-09 14:31:18 +0000, Quentin Monnet wrote:
> 2022-03-09 09:54 UTC+0100 ~ Niklas Söderlund <niklas.soderlund@corigine.com>
> > Commit 1a56c18e6c2e4e74 ("bpftool: Stop supporting BPF offload-enabled
> > feature probing") removed the support to probe for BPF offload features.
> > This is still something that is useful for NFP NIC that can support
> > offloading of BPF programs.
> > 
> > The reason for the dropped support was that libbpf starting with v1.0
> > would drop support for passing the ifindex to the BPF prog/map/helper
> > feature probing APIs. In order to keep this useful feature for NFP
> > restore the functionality by moving it directly into bpftool.
> > 
> > The code restored is a simplified version of the code that existed in
> > libbpf which supposed passing the ifindex. The simplification is that it
> > only targets the cases where ifindex is given and call into libbpf for
> > the cases where it's not.
> 
> [...]
> 
> > +static bool probe_prog_type_ifindex(enum bpf_prog_type prog_type, __u32 ifindex)
> > +{
> > +	struct bpf_insn insns[2] = {
> > +		BPF_MOV64_IMM(BPF_REG_0, 0),
> > +		BPF_EXIT_INSN()
> > +	};
> > +
> > +	switch (prog_type) {
> > +	case BPF_PROG_TYPE_SCHED_CLS:
> > +		/* nfp returns -EINVAL on exit(0) with TC offload */
> > +		insns[0].imm = 2;
> > +		break;
> > +	case BPF_PROG_TYPE_XDP:
> > +		break;
> > +	default:
> > +		return false;
> > +	}
> 
> Looking again at this block, you can remove this switch/case completely.
> Moving 0 by default into R0 was best in generic libbpf's probes because
> there were a number of types that wouldn't accept 2 as a return value;
> but here you can just return 2 all the time, for XDP this will mean
> XDP_PASS and the nfp accepts it. (Do keep the comment on nfp returning
> -EINVAL on exit(0), though, please.)

This make sens and I will do so in a v3. I appreciate your expertise in 
this area, it allows this patch to do more then just restore the code 
from libbpf with as few modifications as possible out of fear of breaking 
things.

> 
> > +
> > +	return probe_prog_load_ifindex(prog_type, insns, ARRAY_SIZE(insns),
> > +				       NULL, 0, ifindex);
> > +}
> > +
> >  static void
> >  probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
> >  		const char *define_prefix, __u32 ifindex)
> > @@ -488,11 +564,19 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
> >  	bool res;
> >  
> >  	if (ifindex) {
> > -		p_info("BPF offload feature probing is not supported");
> > -		return;
> > +		switch (prog_type) {
> > +		case BPF_PROG_TYPE_SCHED_CLS:
> > +		case BPF_PROG_TYPE_XDP:
> > +			break;
> > +		default:
> > +			return;
> > +		}
> > +
> > +		res = probe_prog_type_ifindex(prog_type, ifindex);
> > +	} else {
> > +		res = libbpf_probe_bpf_prog_type(prog_type, NULL);
> >  	}
> >  
> > -	res = libbpf_probe_bpf_prog_type(prog_type, NULL);
> >  #ifdef USE_LIBCAP
> >  	/* Probe may succeed even if program load fails, for unprivileged users
> >  	 * check that we did not fail because of insufficient permissions
> > @@ -521,6 +605,35 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
> >  			   define_prefix);
> >  }
> >  
> > +static bool probe_map_type_ifindex(enum bpf_map_type map_type, __u32 ifindex)
> > +{
> > +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> > +	int key_size, value_size, max_entries;
> > +	int fd;
> > +
> > +	opts.map_ifindex = ifindex;
> > +
> > +	key_size	= sizeof(__u32);
> > +	value_size	= sizeof(__u32);
> > +	max_entries	= 1;
> > +
> > +	switch (map_type) {
> > +	case BPF_MAP_TYPE_HASH:
> > +	case BPF_MAP_TYPE_ARRAY:
> > +		break;
> > +	default:
> > +		return false;
> > +	}
> 
> This switch/case should probably not be here. Either skip
> probe_map_type_ifindex() entirely if you assume other map types are not
> supported, or just probe all types for real.
> 
> Speaking of which, we agreed yesterday on probing for all map types. But
> I think my suggestion was wrong (apologies!), because the simplified
> probes that you're adding back does not contain the necessary
> adjustments to work with all map types (the switch(map_type) in libbpf's
> probe_map_create()). So we should probably probe just hash/array maps,
> but move the switch/case above to probe_map_type(), like we do for prog
> types, to avoid printing any output for other map types. This will
> prevent other drivers to probe for additional map types, but a large
> portion of those probes would be broken, so it's for the best. We can
> always extend probe_map_type_ifindex() in the future to support more
> types if necessary.

Make sens, will do so in v3.

> 
> > +
> > +	fd = bpf_map_create(map_type, NULL, key_size, value_size, max_entries,
> > +			    &opts);
> > +
> > +	if (fd >= 0)
> > +		close(fd);
> > +
> > +	return fd >= 0;
> > +}
> > +
> >  static void
> >  probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
> >  	       __u32 ifindex)

-- 
Regards,
Niklas Söderlund
