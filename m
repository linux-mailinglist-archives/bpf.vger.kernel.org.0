Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A4A3413A7
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 04:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhCSDqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 23:46:13 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:21601
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233691AbhCSDqD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 23:46:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n70TClpOFjhfuAtqjUFItSGPols8JlTaWh2gOGlDbZbug1dGPmqMHwmUawUizhL8OsF9hP9i9Q15ne8bxRx5Q66PxE4p4ayKDmHgaDJui6ShTKT6AjG6/T381tZNFcFQLte2wcjea8HJwxavz4PB5XoS8obAzJvG7U0hscz4Op6mcTP9aJnWzmbWLbRYGpgc8gYfswYpBWRbCXNReyssG8NleCHiXjDlt9YGJewQ4CQL8wM2N0YwFUucqmDgg6iVmyJEQ6oUFCtsTFfhgQ0x9l6jVhvYX2QPvLbC4Yr1duh228z5FKhrocUlS6FGO3ZT2W2FUAhJ0mRhXfjftbGk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DZu8SwcDFZzY3VP7FVQRcGre2G+97HJJ24yoyPuuwM=;
 b=PJLZoZHDI++YsoL/ufUiOnYKrm/a0028UbF80w+TR+GyOoMiAubJn7BwaDdhgRfCpV0i3nBbHfK0sFck+tCJIVkUlHYI6WX6DoP7S0h6Uq2xFfdk7F/mePiHc0N/p54GO1hrFthstkVxTxKcOvos6NX3k0VjovLRuOCUTPqo6RphoGoDd6mgqw9MLsAWsTqkdl49jMdi8cridqHsF/9QIsJ0yzxE3Q4fXtD2npu4UmEHnkgUEo8vwjELT1C8b0mnIXpslQSEsaCer6LLORAugQdrFCuhQe4jSuS9E3xu/1BzKq+6D0yo3iDrjNWU2BsR4WSTykNgbAHiThjXxsOE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DZu8SwcDFZzY3VP7FVQRcGre2G+97HJJ24yoyPuuwM=;
 b=RXZAWIqVjYzAfm8vQsYY2h6uct82ANykahcD6O21keyQCtJPc+13bp7EhqfkSw7F56xlV/S6R4knbtqO5JKn/gfgiUgxfg5zPofWfLf3WoM+RScu0tN2cwue1y/gCkhKQ/N11as3//aRw7wfkj1aMEgd6SIPP4OSBL47PKBsd4I=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BY5PR03MB4998.namprd03.prod.outlook.com (2603:10b6:a03:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 03:45:56 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 03:45:56 +0000
Date:   Fri, 19 Mar 2021 11:45:44 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org
Subject: CLANG LTO compatibility issue with DEBUG_INFO_BTF
Message-ID: <20210319113730.7ad6a609@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:332::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Fri, 19 Mar 2021 03:45:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff2c6c76-4678-4297-0867-08d8ea898041
X-MS-TrafficTypeDiagnostic: BY5PR03MB4998:
X-Microsoft-Antispam-PRVS: <BY5PR03MB4998B219036EE40DF0C5CBF7ED689@BY5PR03MB4998.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbGsuEvCMZ2/Jo8H3CcEYRdtgOwr+ttNEaT7Nbv8GUnsyf915GWSJC2raNVEObUbTKW/jpuxtc1gHauDIAuCn3iZuUqYLpilAYtbYgGoOY8qRDhUgbzYlDYUsA7go6B7A55rfivo1T1bjpSSmOFf9nWO97DLMMxFCSZABiDJhAr0n6n7Iu7AxbgbkVGBJdntcQJ6SxqpEkWngqw5TS6+Y4jJigbrrKQBA1RGx7y0tlFfPq9bBIKgl79eITFqwcu3algyifDwlzYFqdvlVQ1zmSLD2/rC2GyJo30vC3vBYqaEczm4j3Lb6tNlSJBRKRjAyGQPEna13sqfb4S37vwQS9pR1A7xBUl79QS8yxxAM6fxxPDSYN3C+PFCNSF/obWxsYhKSZYRnT+eTS367U+Y8VLEDFKgnk+Mh7YGtOwZLlR/OjhB+Lhf/3Tip15nKOpdUV+4U3uZJDseB4hqpbUQ6aLff4sAnWWMr++us588du3zo2gTpBiK+YVz+888zno2HeqemNdYAPySvCgjfiPXTvHf3nPnTZvDOUUtSdfpa/KAtyEihGN9lbZ+BcOO+uq/9gVmk7JmMQw9MsLGi2gKEBccy5Rb9cPnbX8N1gXiQOvSxPdfxtJk/KUc8oJ6fJ+WszwCPehxL50ryfi52Hy5XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(366004)(376002)(39860400002)(86362001)(6506007)(316002)(2906002)(66476007)(110136005)(478600001)(52116002)(186003)(6666004)(38100700001)(66946007)(66556008)(5660300002)(26005)(4326008)(9686003)(8676002)(16526019)(7696005)(4744005)(956004)(83380400001)(1076003)(8936002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OxPqIJKWPpMaELbAUTinGb7rsMj9W0H/ekpmCiBz5uxqgRzGzKEX4BtuLVW4?=
 =?us-ascii?Q?8e5QWG8rTauBZVbqPlUNjWrev+AxKDOCnohVq0Udno2ffo5Q4U6nfqYI8JwQ?=
 =?us-ascii?Q?QFUBEpo5TIPEZMoAe7q0WzlyrjvtZD0pHHa9QYIDnxbIOca+PPfYZ3bNR0dr?=
 =?us-ascii?Q?8t/OGLonitZXlL0Chd/Mv0LE905PrAI7PCnzbe8FrkOnQvsu8aqTUGK6t/jl?=
 =?us-ascii?Q?56lRLErpx6B5X246AD7cMb+aPYY1v8R+wGpVZFkcwCAJezG1zwIH7J8N53wV?=
 =?us-ascii?Q?wWdLfTbEScrl0bkFeMTj1eKbiNtdP81OXChr+XecS8B4K2sGock7RupDcFuU?=
 =?us-ascii?Q?oFB6m+WdvMeyP90tBfCwGkBwg4boBd0dHJF/sGIY9EXIc3b14thaBthZ5f+1?=
 =?us-ascii?Q?6CL+dhtSF+y2KJTkXJbAJbh6eUX+wyhGFnZVgfIV075FGU0SYOVOOvEV6z7S?=
 =?us-ascii?Q?lOTmk2Suoj9faVPdRhtcjYeRum+EVCI9391i1miSzbcf+07CbTfjuTTXdtiL?=
 =?us-ascii?Q?U2sKugm+dpXV8/RBWFuzLihW1m5F1j/O3nHytXCpAqLnZJDEAFu+VynpNXNe?=
 =?us-ascii?Q?GLAjhqsHaehudJIHHJWCLmprtIJGov7dIkXa5z4kLGxOjUQphLST1D/eaO+X?=
 =?us-ascii?Q?2Sq8O/1eilF62vj4eYTdoY8kqX15z61k4njXGf3f45M0aMAjijggXvyoVRNH?=
 =?us-ascii?Q?0OHSAfdtEiqeEUkF52XD5o84n1CYm2BTbKpJitu99dhWzeiMzsKSF2Bn/Ck0?=
 =?us-ascii?Q?cu7FBPSAWB1O23aJyYthXgVexwPqZzngw25mEXluO3jwct21ZDGgD5lA3SGV?=
 =?us-ascii?Q?grpWZSvQPjAb0axkjCpW4AbKEBbEYcoj2hF4iUZW/e4yLqudjyBh8YcIV1/v?=
 =?us-ascii?Q?pDHqLnVspVdQBWeU28+l//FHO81TLz5Bnm80Op3GcXGFtZoeYQxlE8dobgcV?=
 =?us-ascii?Q?7dzmiWCFrGu8ReErdk7Eap6hw7NiE+LG4I7bxbPr4yOBezgDf58CyoTQ01NQ?=
 =?us-ascii?Q?gXuxeMftN31CjNqRFaTIn4g5Dd3ffo01POFYhOk41xtIHNFqTQrdkMumqFas?=
 =?us-ascii?Q?1OwkcPqwg5UJ/Dy1TV2zQG7P7qOkAN3a/V/2rJ+xjjdbfYOYEoD/HWBkd85y?=
 =?us-ascii?Q?A4AuKKJYl03JEwQ5F4h4ERuhu/vI6f+JpxV0l7tLJ1rKxyFztMzvLLOG4nPA?=
 =?us-ascii?Q?qFnbQTQq5x5YWSrnk1i7z/opw5glPhEWlSyO6WdWk0bbYyKX6vGEjeo4C7AC?=
 =?us-ascii?Q?UPxylPvERPQ43XWpQ0aPMgz8fEykvwTU89IZwFM4ftFnav/IwESzNwPvw5w0?=
 =?us-ascii?Q?0t4vtgyv58ZXqHS0bBK/0Au8?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2c6c76-4678-4297-0867-08d8ea898041
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 03:45:55.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5nVTafnprH+XkivWAkoex7/Yx/cBU2UujzHpEExE3ojmF/UUYSf6t+vXbkxjclzh0M33wPVQtrTiXmHYpA6ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4998
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

When trying the latest 5.12-rc3 with both LTO_CLANG_THIN and DEBUG_INFO_BTF
enabled, I met lots of warnings such as:

...
tag__recode_dwarf_type: couldn't find 0x4a7ade5 type for 0x4ab9f88 (subroutine_type)!
ftype__recode_dwarf_types: couldn't find 0x4a7ade5 type for 0x4ab9fa4 (formal_parameter)!
...
namespace__recode_dwarf_types: couldn't find 0x4a8ff4a type for 0x4aba05c (member)!
namespace__recode_dwarf_types: couldn't find 0x4a7ae9b type for 0x4aba084 (member)!
...
WARN: multiple IDs found for 'path': 281, 729994 - using 281
WARN: multiple IDs found for 'task_struct': 421, 730101 - using 421
...


then finally get build error:
FAILED unresolved symbol vfs_truncate


Is this a known issue? Do we need to make DEBUG_INFO_BTF depend on !LTO?

pahole version: v1.20
clang version: 11.0


Thanks
