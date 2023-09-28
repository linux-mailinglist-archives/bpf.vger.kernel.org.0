Return-Path: <bpf+bounces-11085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA8E7B27AC
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 23:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 438C528390C
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9849D18047;
	Thu, 28 Sep 2023 21:44:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DB1775F
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:44:13 +0000 (UTC)
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 14:44:12 PDT
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB7519D
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 14:44:12 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 68638C17CE9C
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1695936908; bh=NvPX7ttDBJgcE5QNaKZeBSs/HLQNaAHoyqyoWOiAVPU=;
	h=To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yy0laCLqCXDYiK3KEfrNWhhQzmBKdylQ3KzvP2xRGusY5k+z89o6ivJiGD/EMT6ac
	 sgscsjR1RalYaEkJ3f/fC72S9YZ66vXogOprjI27l62MUA47FgMHdxyR+GA9ks6V2k
	 prO9YaIrVk725341nt6A1qx6icZxvnofJDY+gQHs=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 30F56C169510;
 Thu, 28 Sep 2023 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1695936908; bh=NvPX7ttDBJgcE5QNaKZeBSs/HLQNaAHoyqyoWOiAVPU=;
 h=From:To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=E9t/+FPcO+yvSqpndycC7JwPsgjOtsjG/X0b4Erp+D4iJVIg4Bvs1xc9azXXMsPwf
 PyNjD3XgToYJKWXcGzBHGmlie0PyRUkTw9fh3pYOH+qqPH0S43YOE1K/xrRqraEcYP
 XbY7Q7/G8nuGoGVrrYS9GDRvGASUPJ07rsbnAETM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A08E7C169510
 for <bpf@ietfa.amsl.com>; Thu, 28 Sep 2023 14:35:07 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.111
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hn8-g_IOo0iu for <bpf@ietfa.amsl.com>;
 Thu, 28 Sep 2023 14:35:03 -0700 (PDT)
Received: from DM5PR00CU002.outbound.protection.outlook.com
 (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 3F191C15109C
 for <bpf@ietf.org>; Thu, 28 Sep 2023 14:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAJ+w6tD4R7PN4nejww3dQhd20hb1zdMbiIeXvDizMdOHeZb2IxoW9udamwCjMD5UpJpfjEr0ewle334vzdvaz3TG6gQ75zCbWAEAfOe0W4VnwAVm+b8BnaLM+m9XV8xHL7cDhcQF9uNta/2n/3JCqBBvasubOmGY3yPtdy/CXiPFpwlv7XXdpXWG3a0toTpMwXyD8zLOaqP80GvYwtenMsgzJA4cS3RUuqnG5NHDEic9X9MQy+4GKK0pRhXFRrvHspQzP19n8GH0awht70h5ND23p0Vp7QL7HGFqWMdJHqX2mXKZGbko90WOntZq7We61SpVGrwshOVxaUU3GlhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9c1oThLo2DhADgwcr4+m03cg9zWbjVSjw5nPZIAwjk=;
 b=Ydw3lT3jxznkJgM1NFsRd91lX0acsCezsM7gKifdPV8I9tk1Bmtu/nFvzUv5IBvxOvFr7YInHpqGRgSkBJN06SiAl6DCIkOJPagFiKaqNUH2qJJR2HoE4/Rs32hrJAQ00c9NQtb8UIQSfZDbeRkAsshngCQ49esJhqGUVAsw/ddTF+kliYR1gSyrVoh4zUFg46T4sWE1v9lOL4mBVWs+gEYzVnoriCDsit74mxIDvfEer+4M4ToKDRMkM9cf9hK9YGapxN+X13NAYHRWmSINnuvACmcYBq/9DOu5JsyfbVJAUwT+uo4qQC29td1fsRBjQRblo4Oj9Le3s/o3K65e+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9c1oThLo2DhADgwcr4+m03cg9zWbjVSjw5nPZIAwjk=;
 b=PFIkP1LchpuHNWi9YKSmRiXxN6triI/5bZ3wRoOUdFA9vX5PUD/Tl1Sr5qqhrCIah/9/MWKdJyYjh0N19cGU2vqyyFPYC349C1Ovm7lIS3i1tlmdMbl6L9MY+UGouL5NqrK23C7k0UjJnvsww6/CGablfmLLbw/KOTCQ9O4be9U=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SN3PEPF00013D7A.namprd21.prod.outlook.com
 (2603:10b6:82c:400:0:4:0:10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12; Thu, 28 Sep
 2023 21:35:00 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ec5c:279e:7bfe:50e9]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ec5c:279e:7bfe:50e9%3]) with mapi id 15.20.6838.010; Thu, 28 Sep 2023
 21:35:00 +0000
To: Yonghong Song <yonghong.song@linux.dev>
CC: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Thread-Topic: BPF_ALU | BPF_MOVSX with offset = 32?
Thread-Index: AdnyU2uWdXKmAeaFSoSZjtj4SC4uVQ==
Date: Thu, 28 Sep 2023 21:35:00 +0000
Message-ID: <PH7PR21MB3878516D62B3AFA921A999F1A3C1A@PH7PR21MB3878.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=64edff80-3414-43a4-81f7-03e2114d4012;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-28T21:30:21Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SN3PEPF00013D7A:EE_
x-ms-office365-filtering-correlation-id: ced44104-4389-4992-52e6-08dbc06ac4b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tD5YQSWOFO0dEowJzAgDrffNSbA6Yb77mYzkVS74yMelEsKVIiAvB5c07p4+8hlJc8D21lUc/SuyJMp754n2k5NnCrmieZfEDSBIs+Gqt+B8rqFdYpCFqg21qO16nHhzFPOcs0JL+zNrEdQ3O5qGVhzqgwSMl9J0yyQkggpjtPpE7arFHBtp9c4CEzXip/OpCdg3olfqnnSd41IlaNAQllvzlqte7bbDF5Ja4asw87a8uqu24kBFPJpw5+ofpp6D15pnhF+YRw8QvGbPTBeS7d4A4cLTKIox1X3AynBYvvjzVp/MuXlZP4XrgFqD7EV5OV7zQfU1Wj8C32bPHnJh7iqDngdjutQFcjo9kfW1eIkltB97CTrraEJSyaIWXKFms6ngXS7um5LZlSovkKvg7tXeC8pM4hwpp/8IlnA95n4XgWMGVyOjKCa+xkzGLIadvUSpHFGHxOkLA1tJ2wZpIYrI0+wXCj+HlsDX3lsez3jpnfw9CzRpwKBpJ9+nUz0CLtmKGz2MwmwCzkwHK1+DM2o/FfYNY7h3tKZrE8Ays2DFp2DMyKJHcVIq+d/gAl8Vhdx90vJ9kb2+kY1riHw8yaM3mWL/fF7CtbgCsFHhvmzmntdkaBVFn6bjjBBCiNG7LA6z9SAuli7bm9uu6sxIMd5L1EYCuZ8Pos790MBvRys=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(316002)(4326008)(8676002)(6916009)(8936002)(71200400001)(2906002)(5660300002)(54906003)(64756008)(66946007)(66556008)(66476007)(66446008)(76116006)(4744005)(52536014)(10290500003)(478600001)(55016003)(82950400001)(82960400001)(86362001)(9686003)(8990500004)(6506007)(38100700002)(38070700005)(122000001)(33656002)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I68VPOhAtJWA1sh7xQiqFFOkox2Fc1/0pjY8TaGbMMoB40WmvAzijRm5bix0?=
 =?us-ascii?Q?TfhQKDnb4Tc+ES8i21asU8Mq7r6FszKOIFQno+87HbSd7SsFj0rWe2dmPtNU?=
 =?us-ascii?Q?LfQwwTnO5FwyDCNjyXG+73Uq2vk3O8BGzMb1mxE5/bGv8INgnYIdFUattyNt?=
 =?us-ascii?Q?uFKtDpw3W5fFaFymoSeyALgna5etyAhAsv/bltxCuvVISvXOYOpCQ7uZioTg?=
 =?us-ascii?Q?KAUagRgp9BynOpot3da5cyeCDLkcySIusBeDPno0ApbKYBh2CvbNR2cxmboc?=
 =?us-ascii?Q?1MjlXoUYjnoeiEV1UljBxELGMN2ONMaK09OoY7tws2TJ+Mw+n68C5WHa2tt/?=
 =?us-ascii?Q?B7YGKn6iEb2GQAAy5ySl2NkNRqkw+v2qpk3/GIhqf+ta0rLfA482l5BSNZDb?=
 =?us-ascii?Q?rddnxTaoN8BueHUnIoZOUjHWn5yw2V2fC6yJUc5VX9zOnCq9dgSaGlXRJmTj?=
 =?us-ascii?Q?OMqKXPZUugjBGECMdfd2RYoX7dVsaXeU7x60KEdjiF4bKgo5BmDhprM8ryVl?=
 =?us-ascii?Q?mdsBxqSx8b5nIEjOYNxaxQ9+CubzKRdKMmwFUXSBzB9s0jCdRN7Hrsy8hSLK?=
 =?us-ascii?Q?V78rUXxL9h63du9C5HDAUTJ7NqHYNGYgygTLF+Ah1zlKWDpK2ir9xTBm83v7?=
 =?us-ascii?Q?iPGbHfCr/S9mXvD0Bc+O2cWy9uShFcBP8I6ddMATMrp5gxlBCjdx+ThabjNv?=
 =?us-ascii?Q?QpK5XB5cQQqaY7CknjwcEYgHO4XrcASyEcXLyQH5aWtTicXwMwsR23RMWVzG?=
 =?us-ascii?Q?MEY032KxIsuz/hUaa4NEWwg6hiHwtDYpq0BJ3fCKV+oRI3uNdRK/uIUDzC9V?=
 =?us-ascii?Q?KWfnf/8zPcWMwvtz2w2sx0lKfzGgblwvx1KQYAVYAFwnAFJY0964vrg7r3H0?=
 =?us-ascii?Q?T2lr2EikCmdscH5CGbjYFr5ySWvL8/ZX1/RYugDP3ONI25CSs6hS7Dq2pbxi?=
 =?us-ascii?Q?2R0ejRZ34tdIgDmPMk9dwbAeJhovTKzLrxH++GuhIWQYgrKTpx4VI6dqtWuZ?=
 =?us-ascii?Q?BeHEznHbqZvt/nRuU3xjEQBRuNpUtaQrVybWD2cA1rOyqrXlW22b8gMS9P06?=
 =?us-ascii?Q?O+9ukas5VXps422LTEWfDEle/JF2RgtKewIeVfMzzuSXGT71cuIeJ686P7IH?=
 =?us-ascii?Q?+TPaMiRBTiLe02+ONAiXjNe3WsDwCii2hC7OSyo6PhcO2zXYNG8gpBhXMKbw?=
 =?us-ascii?Q?UKU3nmefzE3Ea69zJdJD6tPs8/oZfdHCtU3rK2KdcIe7eSDd1gLQwoZSFkgv?=
 =?us-ascii?Q?d1vDlSy5RFo3NhNAyycDcv+b08cc42pynx4ASMex4iPvPzGyW4RNNxr6c/TH?=
 =?us-ascii?Q?f5khuVvPrX0d1yEkC55lk9/ql6syEJscu8QVapfXJlETDnaz9sJ5VoUjjhzN?=
 =?us-ascii?Q?7eYYQhJ8yfP98/FOJUd217wRv2YBNJ3PUIoYirzVK89ebByUoRqCkIz2w+Nr?=
 =?us-ascii?Q?ZwdZhxB1oNV61oZOY6ISrRtOI46m5nkSrjIMXBDo3nvtNboC9OWqsC2YGTyO?=
 =?us-ascii?Q?lGLF9nxEayuZ98bvNY8e8K4jI+SkF3ui5bMWVmgBwVf/mId2aZy/hiq6nizG?=
 =?us-ascii?Q?wTDX2hZmkEzn2n4p8iQzCEc1Gx/d9Hg1EgPGNMAyULBYknDeDhz7PRDQvdiB?=
 =?us-ascii?Q?RPQgFHoZEU+GbG67h+f5sa8sv4b05cbqid5lyKrNv3gI8WHcjVpisFoccgmZ?=
 =?us-ascii?Q?fz+65A=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced44104-4389-4992-52e6-08dbc06ac4b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 21:35:00.1715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iBt8nv1KxGQ2o5FA2oad0aQwtcKpuYM3WtVweg9GgfvMLIJh2bfcxACZjOIjoW55TkbGYd9sHIi1pQ9g2LCquHMnHV3Tj8Vd/PuyUpmcf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN3PEPF00013D7A
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/CXXYW1bKT3XA8GJtU2yPSInr_kI>
Subject: [Bpf] BPF_ALU | BPF_MOVSX with offset = 32?
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In re-reading the instruction-set.rst changes for sign extensions, there is one ambiguity
regarding BPF_ALU | BPF_MOVSX with offset = 32.

Is it:
a) Undefined (not a permitted instruction), or
b) Defined as being synonymous with BPF_ALU | BPF_MOV?

The table implies (b) when it says:
> BPF_MOVSX  0xb0   8/16/32  dst = (s8,s16,s32)src

But the following text could be interpreted as ():
> ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
> bit operands, and zeroes the remaining upper 32 bits.

There's no reason I can think of to use it, given it's synonymous but if given a BPF program that
uses it, should it be rejected by a verifier/disassembler/etc.?  Or treated as valid?

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

